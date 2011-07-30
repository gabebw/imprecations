require "imprecations/version"

module Imprecations
  def imprecate
    if [Object, Module, Kernel].include?(self)
      raise "Imprecate *#{self}*?! Sorry, even I'm not that evil."
    end

    __imprecate(self)
    self.imprecate_child_constants
  end

  def imprecate_child_constants
    real_constants  = self.constants.map{|c| self.const_get(c) }
    class_constants = real_constants.select{|c| Class === c }
    class_constants.each do |class_const|
      class_const.imprecate
    end
  end

  def __imprecate(constant)
    unimprecated_instance_methods_for(constant).each do |meth|
      namespaced_constant =
        if self.superclass == Object
          "#{constant}"
        else
          "#{self.superclass}::#{constant}"
        end

      constant.class_eval <<-EVIL
        # Store a reference
        alias :"__unimprecated_#{meth}" :"#{meth}"

        # Undefine it so we can redefine it
        undef_method(:"#{meth}")

        def #{meth}
          Imprecations.say("DEPRECATION WARNING: #{namespaced_constant}##{meth} is deprecated!")
          __unimprecated_#{meth}()
        end
      EVIL
    end
  end

  def unimprecated_instance_methods_for(constant)
    methods = constant.instance_methods(false)
    methods.reject{|meth| meth.to_s =~ /^__unimprecated/ }
  end

  def say(message)
    puts message
  end
end

include Imprecations
