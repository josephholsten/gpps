require 'src/generational_search'

# y = mx+b  (kids = m, b)
class StraightLine < TreeProgram
  include Function
  def call(*variables)
    slope_value = @kids[0].call(*variables)
    x_value = variables[0]
    y_intercept_value = @kids[1].call(*variables)
    
    slope_value * x_value + y_intercept_value
  end

  def populate_kids(functions, terminals, depth_limit = nil)
    if !depth_limit || depth_limit > 2
      programs = functions + terminals
    elsif depth_limit == 2
      programs = terminals
    end
    
    # the index must be one less than ordinality, ie arr[0] is 1st, arr[2] is 3rd
    for i in 0..(self.valid_kid_range.first - 1)
      @kids[i] = programs.random.new unless @kids[i]      
      @kids[i].parent = self
      @kids[i].populate_kids(functions, terminals, depth_limit ? depth_limit - 1 : nil)
    end
  end

  def valid_kid_range
    (2..2)
  end
end

# y = ax^2 + bx + c    (kids = a, b, c)
class Parabola < TreeProgram
  include Function
  def call(*variables)
    x_value = variables[0]
    a_value = @kids[0].call(*variables)
    b_value = @kids[1].call(*variables)
    c_value = @kids[2].call(*variables)
    
    (a_value * x_value**2) + (b_value * x_value) + c_value
  end

  def populate_kids(functions, terminals, depth_limit = nil)
    if !depth_limit || depth_limit > 2
      programs = functions + terminals
    elsif depth_limit == 2
      programs = terminals
    end
    
    # the index must be one less than ordinality, ie arr[0] is 1st, arr[2] is 3rd
    for i in 0..(self.valid_kid_range.first - 1)
      @kids[i] = programs.random.new unless @kids[i]      
      @kids[i].parent = self
      @kids[i].populate_kids(functions, terminals, depth_limit ? depth_limit - 1 : nil)
    end
  end

  def valid_kid_range
    (3..3)
  end
end

# y = log(x)*a + b    (kids = a,b)
class Logarithm < TreeProgram
  include Function
  def call(*variables)
    x_value = variables[0]
    log_value = @kids[0].call(*variables)
    base_value = @kids[1].call(*variables)
    
    begin
      #ret =  Math.log(x_value*log_value)/Math.log(base_value)
      ret = Math.log(x_value)*log_value + base_value
      ret = 0.0 if !ret.finite?
    rescue
      ret = 0.0
    end
    
    ret
  end

  def populate_kids(functions, terminals, depth_limit = nil)
    if !depth_limit || depth_limit > 2
      programs = functions + terminals
    elsif depth_limit == 2
      programs = terminals
    end
    
    # the index must be one less than ordinality, ie arr[0] is 1st, arr[2] is 3rd
    for i in 0..(self.valid_kid_range.first - 1)
      @kids[i] = programs.random.new unless @kids[i]      
      @kids[i].parent = self
      @kids[i].populate_kids(functions, terminals, depth_limit ? depth_limit - 1 : nil)
    end
  end

  def valid_kid_range
    (2..2)
  end
end


def run_test(historical, num_generations)
  #num_generations = 100
  max_tree_depth = 4
  population_size = 100
  tournament_size = 3
  mutation_prob = 0.4
  reproduction_prob = 0.2
  crossover_prob = 0.4

  # Generate the *perfect* function based on known values
  test_data = historical.keys.sort
  perfect = nil
  perfect_eval =   "perfect = lambda {|j| \n"
  historical.each { |size, time| perfect_eval += "return #{time} if j==#{size}\n" }
  perfect_eval += "}\n"
  eval(perfect_eval)

  # Using some non-standard functions in the mix
  terminals = Terminals + [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero]
  functions = [Logarithm, Parabola, StraightLine, Multiply, Divide, Plus, Subtract, Squared, Cubed]
  p = Population.new :functions => functions, :terminals => terminals, :size => population_size, :maxdepth => max_tree_depth

  g = GenerationalSearch.new :generations => num_generations, :tournament_size => tournament_size, :mutation => mutation_prob, :reproduction => reproduction_prob, :crossover => crossover_prob

  best = g.search(p, perfect, test_data)

  print "FITNESS(#{best.fitness(perfect, test_data)})\n"
  print "BEST: #{best}\n\n"
  return {:function => best, :fitness => best.fitness(perfect, test_data)}
end

# Approximatly exponential
historical = { 1 => 36, 2 => 39, 3 => 35, 4 => 41, 6 => 65, 8 => 80, 10 => 120, 11=> 122, 14 => 235}
run_test(historical, 25)
print "\n\n"

# Approximatly linear
historical = { 1 => 38, 2 => 52, 5 => 78, 6 => 83, 8 => 111, 9 => 125, 10 => 125, 16=> 178, 17 => 166}
run_test(historical, 25)
print "\n\n"

# Approximatly logarithmic
historical = { 1 => 30, 2 => 69, 3 => 90, 4 => 105, 6 => 111, 8 => 126, 10 => 111, 11=> 120, 14 => 126, 19 =>128}
run_test(historical, 25)
