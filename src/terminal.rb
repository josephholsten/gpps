require 'src/tree_program'

module Terminal
  attr_accessor :parent, :kids

  # Returns <code>0</code> because Terminals should never depend on any variables.
  def arity
    0
  end
  
  # Returns <code>1</code> because Terminals have no kids.
  def depth
    1
  end
  
  # Evaluate the current node, and return the string representation of this
  # value. Because Terminals are atomic, this should not hide any logic and
  # should give a good idea of what the terminal "means" to the program.
  def to_s
    call.to_s
  end
  
  # Return the range for the valid number of kids. Because Terminals may
  # have no less and no more than 0 kids, this always returns (0..0).
  def valid_kid_range
    (0..0)
  end
end

def Number(n)
  eval <<-END
    Class.new(TreeProgram) do
      include Terminal
      def call(*variables)
        return #{n}
      end
    end
  END
end

class NegativeFive < Number(-5)
end

class NegativeFour < Number(-4)
end

class NegativeThree < Number(-3)
end

class NegativeTwo < Number(-2)
end

class NegativeOne < Number(-1)
end

class Zero < Number(0)
end

class PositiveOne < Number(1)
end

class PositiveTwo < Number(2)
end

class PositiveThree < Number(3)
end

class PositiveFour < Number(4)
end

class PositiveFive < Number(5)
end

class VariableZero < TreeProgram
  include Terminal
  
  # Returns the first parameter.
  def call(*variables)
    variables[0]
  end
  
  # Return 1 because this class only operates on first parameter, any
  # others are ignored.
  def arity
    1
  end
  
  # Returns _x_ because that seems like a reasonable representation of a
  # default variable.
  def to_s
    "x"
  end
end

Terminals = [NegativeFive,
             NegativeFour,
             NegativeThree,
             NegativeTwo,
             NegativeOne,
             Zero,
             PositiveOne,
             PositiveTwo,
             PositiveThree,
             PositiveFour,
             PositiveFive]
Variables = [VariableZero]