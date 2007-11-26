require 'src/generational_search'

class TreeProgram
  def fitness(expected_program, test_data = nil)
    data = test_data || (0..5)
    data.collect {|datum|
      ex = expected_program.call(datum)
      se = self.call(datum)
      
      if ex == 0 then #expect even number
        if se %2.0 == 0.0 then 
          (ex - se)**2.0 #expected and got an even
        else 
          (ex - se)**4.0 #expected even but got an odd
        end
      else #expect odd number
        if se %2.0 == 1.0 then
          (ex - se)**2.0 #expected and got an odd number
        else
          (ex - se)**4.0 #expected odd but got an even
        end
      end      
    }.average
  end
end

num_generations = 100
max_tree_depth = 4
population_size = 100
tournament_size = 3
mutation_prob = 0.4
reproduction_prob = 0.2
crossover_prob = 0.4

num_points = 40
test_data = (-num_points/2)..(num_points/2)

perfect = lambda {|j| j%2 }  

p = Population.new :functions => Functions, :terminals => Terminals+[VariableZero], :size => population_size, :maxdepth => max_tree_depth

g = GenerationalSearch.new :generations => num_generations, :tournament_size => tournament_size, :mutation => mutation_prob, :reproduction => reproduction_prob, :crossover => crossover_prob

best = g.search(p, perfect, test_data)

print "FITNESS(#{best.fitness(perfect, test_data)})\n"
print "BEST: #{best}\n\n"
