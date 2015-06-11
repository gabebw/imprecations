# Imprecations: Because that's what you'll be hurling at the screen

[![Build Status](https://travis-ci.org/gabebw/imprecations.svg?branch=master)](https://travis-ci.org/gabebw/imprecations)

Imprecations recursively deprecates every instance method on a class/module as
well as all classes defined inside that class/module.

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
