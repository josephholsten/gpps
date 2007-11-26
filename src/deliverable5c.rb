require 'src/generational_search'

def run_test(historical)
  num_generations = 100
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
  perfect_eval += "\"asdf\"}\n"
  eval(perfect_eval)

  # Using some non-standard functions in the mix
  terminals = [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero]
  functions = [Multiply, Divide, Plus, Subtract, Squared, Logarithm]
  p = Population.new :functions => functions, :terminals => terminals, :size => population_size, :maxdepth => max_tree_depth

  g = GenerationalSearch.new :generations => num_generations, :tournament_size => tournament_size, :mutation => mutation_prob, :reproduction => reproduction_prob, :crossover => crossover_prob

  best = g.search(p, perfect, test_data)

  print "FITNESS(#{best.fitness(perfect, test_data)})\n"
  print "BEST: #{best}\n\n"
end

# Approximatly exponential
historical = { 1 => 36, 2 => 39, 3 => 35, 4 => 41, 6 => 65, 8 => 80, 10 => 120, 11=> 122, 14 => 235}
run_test(historical)
print "\n\n"

# Approximatly linear
historical = { 1 => 38, 2 => 52, 5 => 78, 6 => 83, 8 => 111, 9 => 125, 10 => 125, 16=> 178, 17 => 166}
run_test(historical)
print "\n\n"

# Approximatly logarithmic
historical = { 1 => 30, 2 => 69, 3 => 90, 4 => 105, 6 => 111, 8 => 126, 10 => 111, 11=> 120, 14 => 126}
run_test(historical)
