require 'src/customMethods'

Infinity = 1.0/0

class Function
  attr_accessor :parent
  
  # Creates and executable function with an array of programs as
  # inputs. If there are not enough input programs provided at
  # initialization, more can be generated with
  # Fuction#populate_children.
  def initialize(programs = [])
    @kids = programs
    @kids.each {|kid|
      kid.parent = self
    }
  end
  
  def [](*params)
    call(*params)
  end
  
  # The number of used parameters depends on which variables are
  # actually used in the program. This searches for any terminals
  # which are variables and returns the greatest arity it finds.
  def arity
    @kids.collect {|k|
      k.arity
    }.max
  end

  def populate_kids(functions, terminals, depth_limit = nil)
    if !depth_limit || depth_limit > 2
      programs = functions + terminals
    elsif depth_limit == 2
      programs = terminals
    end

    for i in 0..2      
    # for i in 0..(self.valid_kids_range.first)
      @kids[i] = programs.random.new unless @kids[i]
    end
    
    @kids.each{|kid|
      kid.parent = self
      kid.populate_kids(functions, terminals, depth_limit ? depth_limit - 1 : nil)
    }
  end
  
  def depth
    @kids.collect {|k|
      k.depth
    }.max + 1
  end
  
  def size
    @kids.inject(1) {|sum,k|
      k.size + sum
    }
  end
  
  def to_s
    kids_string = @kids.inject("(#{self.class}") {|str,k|
      str + " #{k}"
    } + ")"
  end

  def valid_kids?
    valid_kid_range === @kids.length
  end
  
  def too_few_kids?
    valid_kid_range.first > @kids.length
  end
  
  def too_many_kids?
    valid_kid_range.last < @kids.length
  end
  
  def root?
    @parent.nil?
  end
end

class Plus < Function
  def call(*variables)
    @kids[0].call(*variables) + @kids[1].call(*variables)
  end
  def min_kids
    2
  end
  def max_kids
    2
  end
end

class Subtract < Function   
  def call(*variables)
    @kids[0].call(*variables) - @kids[1].call(*variables)
  end
  
  def valid_kid_range
    (2..2)
  end
end

class Multiply < Function
  def call(*variables)
    @kids[0].call(*variables) * @kids[1].call(*variables)
  end

  def valid_kid_range
    (2..2)
  end
end

class Modulus < Function
  def call(*variables)
    second_value = @kids[1].call(*variables)
    if second_value != 0
      @kids[0].call(*variables) % second_value
    else
      0
    end
  end

  def valid_kid_range
    (2..2)
  end
end

class Divide < Function
  def call(*variables)
    second_value = @kids[1].call(*variables)
    if second_value != 0
      @kids[0].call(*variables) / second_value
    else
      0
    end
  end

  def valid_kid_range
    (2..2)
  end
end

Functions = [Plus, Subtract, Multiply, Modulus, Divide]