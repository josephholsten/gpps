class Terminal
  attr_accessor :parent
  
  # defers to the subclass implementation of #call()
  def [](*params)
    call(*params)
  end
  
  # Always returns zero, as it should never depend on any variables
  def arity
    0
  end
  
  # Does nothing, as terminals have no kids
  def populate_kids(functions, terminals, depth)
  end
  
  def depth
    1
  end
  def size
    1
  end
  def to_s
    call.to_s
  end
  
  # Having no kids, there should always be a valid nimber of kids.
  def valid_kids?
    true
  end
  
  # Having no kids, there should never be too few kids.
  def too_few_kids?
    false
  end
  
  # Having no kids, there should never be too many kids.
  def too_many_kids?
    false
  end
  
  def root?
    @parent.nil?
  end

  def ==(obj)
    self.to_s == obj.to_s
  end
end

def Number(n)
  eval <<-END
    Class.new(Terminal) do
      def call(*variables)
        return #{n}
      end
    end
  END
end

class NegativeFive < Number -5
end

class NegativeFour < Number -4
end

class NegativeThree < Number -3
end

class NegativeTwo < Number -2
end

class NegativeOne < Number -1
end

class Zero < Number 0
end

class PositiveOne < Number 1
end

class PositiveTwo < Number 2
end

class PositiveThree < Number 3
end

class PositiveFour < Number 4
end

class PositiveFive < Number 5
end

class VariableZero < Terminal
  
  # Returns the first parameter
  def call(*variables)
    variables[0]
  end
  
  # Only operates on first parameter, any others are ignored
  def arity
    1
  end
  
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
             