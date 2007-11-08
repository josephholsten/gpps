require 'src/generational_search'

num_generations = 50
max_tree_depth = 4
population_size = 100
tournament_size = 3
test_data = -5..5  # has jonyer said anything about what this default should be?
mutation_prob = 0.4
reproduction_prob = 0.2
crossover_prob = 0.4

perfect = lambda {|j| (((1.0*j) ** 2) * 0.5) + 1}
#perfect = lambda {|j| ((1.0*j) ** 6) -(2.0*((1.0*j)**4)) + ((1.0*j)**2) }  # (x**6 - 2x**4 + x**2)

p = Population.new :functions => Functions, :terminals => Terminals+[VariableZero], :size => population_size, :maxdepth => max_tree_depth
# I know we shouldn't need to but it helps quiet a bit if we trim down the number of terminals
#p = Population.new :functions => [Multiply, Divide, Plus], :terminals => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero], :size => population_size, :maxdepth => max_tree_depth

g = GenerationalSearch.new(num_generations, tournament_size,  mutation_prob, reproduction_prob, crossover_prob)

best = g.search(p, perfect, test_data)

print "FITNESS: #{Program.fitness(perfect, best, test_data)}\n"
print "BEST: #{best}\n"