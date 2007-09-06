class Terminal
  def [](*params)
    call(*params)
  end
  def arity
    0
  end
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
end

def Number(n)
  eval <<-END
    Class.new(Terminal) do
      def call(variables=nil)
        #{n}
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
  def call(variables = nil)
    variables[0]
  end
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
             