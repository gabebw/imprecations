require 'spec_helper'

describe Imprecations, "#imprecate" do
  before do
    Object.send(:remove_const, :MyModule) if defined?(MyModule)
    Object.send(:remove_const, :MyClass) if defined?(MyClass)

    module MyModule; end

    class MyClass
      class MySubClass
        def sub_one
        end

        class MyTripleSubClass
          def triple_sub
          end
        end
      end

      def one; end
      def two; end

      def three
        called_by_three
      end

      def called_by_three
      end
    end
  end

  it "is available on any Object" do
    MyClass.should respond_to :imprecate
    MyClass::MySubClass.should respond_to :imprecate
    MyModule.should respond_to :imprecate
  end

  it "adds deprecation warnings for every instance method" do
    Imprecations.should_receive(:say).with("DEPRECATION WARNING: MyClass#one is deprecated!")
    Imprecations.should_receive(:say).with("DEPRECATION WARNING: MyClass#two is deprecated!")

    MyClass.imprecate
    instance = MyClass.new
    instance.one
    instance.two
  end

  it "recursively adds deprecation warnings for every instance method" do
    Imprecations.should_receive(:say).with("DEPRECATION WARNING: MyClass::MySubClass::MyTripleSubClass#triple_sub is deprecated!")

    MyClass.imprecate
    MyClass::MySubClass::MyTripleSubClass.new.triple_sub
  end

  it "calls the original method" do
    MyClass.any_instance.should_receive(:called_by_three)

    MyClass.imprecate
    MyClass.new.three
  end

  [Object, Module, Kernel].each do |important_class|
    it "refuses to imprecate #{important_class}" do
      lambda do
        important_class.imprecate
      end.should raise_error
    end
  end
end
