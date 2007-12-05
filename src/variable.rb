require 'src/terminal'

module Variable
  # Returns the parameter from the position equivalent to it's ordinality.
  def call(*variables)
    variables[ordinality]
  end
  
  # Return 1 + ordinality because this class only operates on this parameter, any
  # others being ignored.
  def arity
    1 + ordinality
  end
  
  # Returns _x_ because that seems like a reasonable representation of a
  # default variable.
  def to_s
    "x" << ordinality.to_s
  end
end

def BuildVariable(n)
  eval <<-END
    Class.new(TreeProgram) do
      include Terminal
      include Variable
      def ordinality
        return #{n}
      end
    end
  END
end

class VariableZero        < BuildVariable( 0); end
class VariableOne         < BuildVariable( 1); end
class VariableTwo         < BuildVariable( 2); end
class VariableThree       < BuildVariable( 3); end
class VariableFour        < BuildVariable( 4); end
class VariableFive        < BuildVariable( 5); end
class VariableSix         < BuildVariable( 6); end
class VariableSeven       < BuildVariable( 7); end
class VariableEight       < BuildVariable( 8); end
class VariableNine        < BuildVariable( 9); end
class VariableTen         < BuildVariable(10); end
class VariableEleven      < BuildVariable(11); end
class VariableTwelve      < BuildVariable(12); end
class VariableThirteen    < BuildVariable(13); end
class VariableFourteen    < BuildVariable(14); end
class VariableFifteen     < BuildVariable(15); end
class VariableSixteen     < BuildVariable(16); end
class VariableSeventeen   < BuildVariable(17); end
class VariableEighteen    < BuildVariable(18); end
class VariableNineteen    < BuildVariable(19); end
class VariableTwenty      < BuildVariable(20); end
class VariableTwentyOne   < BuildVariable(21); end
class VariableTwentyTwo   < BuildVariable(22); end
class VariableTwentyThree < BuildVariable(23); end
class VariableTwentyFour  < BuildVariable(24); end

Variables = [VariableZero]
AllVariables = [
  VariableZero,
  VariableOne,
  VariableTwo,
  VariableThree,
  VariableFour,
  VariableFive,
  VariableSix,
  VariableSeven,
  VariableEight,
  VariableNine,
  VariableTen,
  VariableEleven,
  VariableTwelve,
  VariableThirteen,
  VariableFourteen,
  VariableFifteen,
  VariableSixteen,
  VariableSeventeen, 
  VariableEighteen,
  VariableNineteen,
  VariableTwenty,
  VariableTwentyOne,
  VariableTwentyTwo,
  VariableTwentyThree,
  VariableTwentyFour
]