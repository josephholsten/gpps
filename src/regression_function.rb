require 'src/tree_program'

class StraightLine < TreeProgram
  include Function
  
  # y = mx+b  (kids = m, b)
  def call(*variables)
    slope_value = @kids[0].call(*variables)
    x_value = variables[0]
    y_intercept_value = @kids[1].call(*variables)
    
    slope_value * x_value + y_intercept_value
  end

  def valid_kid_range
    (2..2)
  end
end

class Parabola < TreeProgram
  include Function
  
  # y = ax^2 + bx + c    (kids = a, b, c)
  def call(*variables)
    x_value = variables[0]
    a_value = @kids[0].call(*variables)
    b_value = @kids[1].call(*variables)
    c_value = @kids[2].call(*variables)
    
    (a_value * x_value**2) + (b_value * x_value) + c_value
  end

  def valid_kid_range
    (3..3)
  end
end

class Logarithm < TreeProgram
  include Function
  
  # y = log(x)*a + b    (kids = a,b)
  def call(*variables)
    x_value = variables[0]
    log_value = @kids[0].call(*variables)
    base_value = @kids[1].call(*variables)
    
    begin
      ret = Math.log(x_value)*log_value + base_value
      ret = 0.0 if !ret.finite?
    rescue
      ret = 0.0
    end
    
    ret
  end

  def valid_kid_range
    (2..2)
  end
end