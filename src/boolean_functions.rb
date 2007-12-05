require 'src/function'
 
class And < TreeProgram
  include Function
  
  def call(*variables)
    if @kids[0].call(*variables) and @kids[1].call(*variables)
      1
    else
      0
    end
  end
  
  def valid_kid_range
    (2..2)
  end
end
  
class Or < TreeProgram
  include Function
  
  def call(*variables)
    if @kids[0].call(*variables) or @kids[1].call(*variables)
      1
    else
      0
    end
  end
  
  def valid_kid_range
    (2..2)
  end
end

class Xor < TreeProgram
  include Function
  
  def call(*variables)
    if (@kids[0].call(*variables) and !@kids[1].call(*variables)) or
        ( !@kids[0].call(*variables) and @kids[1].call(*variables))
      1
    else
      0
    end
  end
  
  def valid_kid_range
    (2..2)
  end
end

class Not < TreeProgram
  include Function
  
  def call(*variables)
    unless @kids[0].call(*variables)
      1
    else
      0
    end
  end
  
  def valid_kid_range
    (1..1)
  end
end

BooleanFunctions = [And, Or, Xor, Not]