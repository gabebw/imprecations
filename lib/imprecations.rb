require "imprecations/version"

module Imprecations
  DO_NOT_IMPRECATE = [Object, Module, Kernel]

  def imprecate
    if DO_NOT_IMPRECATE.include?(self)
      raise "Imprecate *#{self}*?! Sorry, even I'm not that evil."
    end

    imprecate_self
    imprecate_child_constants
  end

  def imprecate_child_constants
    constant_names = constants
    real_constants = constant_names.map { |c| const_get(c) }
    class_constants = real_constants.select { |c| Class === c }
    class_constants.each(&:imprecate)
  end

  private

  def imprecate_self
    unimprecated_instance_methods_for(self).each do |method_name|
      class_eval <<-EVIL
        # Store a reference
        alias :"__unimprecated_#{method_name}" :"#{method_name}"

        # Undefine it so we can redefine it
        undef_method "#{method_name}"

        def #{method_name}
          $stderr.puts "DEPRECATION WARNING: #{self}##{method_name} is deprecated!"
          __unimprecated_#{method_name}()
        end
      EVIL
    end
  end

  def unimprecated_instance_methods_for(constant)
    instance_methods_from_this_class = constant.instance_methods(false)
    instance_methods_from_this_class.reject do |method|
      method.to_s =~ /^__unimprecated/
    end
  end
end

include Imprecations
