# Imprecations: Because that's what you'll be hurling at the screen

Imprecations deprecates every instance method on a class.

## Installation

    gem install imprecations

## Usage

    MyClass.imprecate
    MyClass.my_method
    #=> DEPRECATION WARNING: MyClass#my_method is deprecated!
    #=> ...my_method does its thing...

## Safety
Worried about deprecating too many things? Just do this:

    require 'imprecations/safe'

And you're good to go!


## Is it tested?
Of course!

Author/who to blame: Gabe Berke-Williams, 2011
