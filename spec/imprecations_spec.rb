require 'spec_helper'

describe Imprecations, "#imprecate" do
  before do
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

  after do
    Object.send(:remove_const, :MyModule)
    Object.send(:remove_const, :MyClass)
  end

  it "is available on any Object" do
    expect(MyClass).to respond_to :imprecate
    expect(MyClass::MySubClass).to respond_to :imprecate
    expect(MyModule).to respond_to :imprecate
  end

  it "adds deprecation warnings for every instance method" do
    allow(Imprecations).to receive(:say)

    MyClass.imprecate
    instance = MyClass.new
    instance.one
    instance.two

    expect(Imprecations).to have_received(:say).
      with("DEPRECATION WARNING: MyClass#one is deprecated!")
    expect(Imprecations).to have_received(:say).
      with("DEPRECATION WARNING: MyClass#two is deprecated!")
  end

  it "recursively adds deprecation warnings for every instance method" do
    allow(Imprecations).to receive(:say)

    MyClass.imprecate
    MyClass::MySubClass::MyTripleSubClass.new.triple_sub

    expect(Imprecations).to have_received(:say).
      with("DEPRECATION WARNING: MyClass::MySubClass::MyTripleSubClass#triple_sub is deprecated!")
  end

  it "calls the original method" do
    MyClass.imprecate
    my_class = MyClass.new
    allow(my_class).to receive(:called_by_three)

    silence_stdout
    my_class.three

    expect(my_class).to have_received(:called_by_three)
  end

  [Object, Module, Kernel].each do |important_class|
    it "refuses to imprecate #{important_class}" do
      expect { important_class.imprecate }.to raise_error
    end
  end

  def silence_stdout
    allow(STDOUT).to receive(:puts)
  end
end
