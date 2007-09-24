require 'src/customMethods'

class Function
  def initialize(programs = [])
    @kids = programs
  end
  
  def [](*params)
    call(*params)
  end
  
  def arity
    @kids.collect {|k|
      k.arity
    }.max
  end

  def populate_kids(functions, terminals, depth)
    if !depth || depth > 2
      programs = functions + terminals
    elsif depth == 2
      programs = terminals
    end

    for i in 0..1
      @kids[i] = programs.random.new unless @kids[i]
    end
    
    @kids.each{|k|
      k.populate_kids(functions, terminals, depth ? depth - 1 : nil)
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
end

class Plus < Function
  def call(variables = nil)
    @kids[0].call(variables) + @kids[1].call(variables)
  end
end

class Subtract < Function   
  def call(variables = nil)
    @kids[0].call(variables) - @kids[1].call(variables)
  end
end

class Multiply < Function
  def call(variables = nil)
    @kids[0].call(variables) * @kids[1].call(variables)
  end
end

class Modulus < Function
  def call(variables = nil)
    second_value = @kids[1].call(variables)
    if second_value != 0
      @kids[0].call(variables) % second_value
    else
      0
    end
  end
end

class Divide < Function
  def call(variables = nil)
    second_value = @kids[1].call(variables)
    if second_value != 0
      @kids[0].call(variables) / second_value
    else
      0
    end
  end
end

Functions = [Plus, Subtract, Multiply, Modulus, Divide]