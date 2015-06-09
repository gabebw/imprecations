require "imprecations/version"

module Imprecations
  def imprecate
    if [Object, Module, Kernel].include?(self)
      raise "Imprecate *#{self}*?! Sorry, even I'm not that evil."
    end

    __imprecate(self)
    imprecate_child_constants
  end

  def imprecate_child_constants
    real_constants = constants.map { |c| const_get(c) }
    class_constants = real_constants.select { |c| Class === c }
    class_constants.each(&:imprecate)
  end

  def say(message)
    puts message
  end

  private

  def __imprecate(constant)
    unimprecated_instance_methods_for(constant).each do |method_name|
      namespaced_constant = if superclass == Object
                              constant.to_s
                            else
                              "#{superclass}::#{constant}"
                            end

      constant.class_eval <<-EVIL
        # Store a reference
        alias :"__unimprecated_#{method_name}" :"#{method_name}"

        # Undefine it so we can redefine it
        undef_method "#{method_name}"

        def #{method_name}
          Imprecations.say("DEPRECATION WARNING: #{namespaced_constant}##{method_name} is deprecated!")
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
