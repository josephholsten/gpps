require 'src/generational_search'

def myFitness(expected_program, test , test_data = nil)
  data = test_data || (0..5)
  data.collect {|datum|
    (expected_program.call(datum) - test.call(datum)) ** 2
  }.average
end

def runTest(input = {})
  num_generations = input[:num_generations]
  max_tree_depth = input[:max_tree_depth]
  population_size = input[:population_size]
  tournament_size = input[:tournament_size]
  mutation_prob = input[:mutation_prob]
  reproduction_prob = input[:reproduction_prob]
  crossover_prob = input[:crossover_prob]

  #test_data = -5..5
  num_points = 200
  test_data = 0..num_points
  test_data = (0..num_points).collect { |x| -5.0 + (((x*1.0))/(num_points/10))}

  #perfect = lambda {|j| (((1.0*j) ** 2) * 0.5) + 1}
  perfect = lambda {|j| ((1.0*j) ** 6) -(2.0*((1.0*j)**4)) + ((1.0*j)**2) }  # (x**6 - 2x**4 + x**2)

  p = Population.new :functions => Functions, :terminals => Terminals+[VariableZero], :size => population_size, :maxdepth => max_tree_depth
  # I know we shouldn't need to but it helps quiet a bit if we trim down the number of terminals
  #p = Population.new :functions => [Multiply, Plus], :terminals => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero], :size => population_size, :maxdepth => max_tree_depth

  g = GenerationalSearch.new :generations => num_generations, :tournament_size => tournament_size, :mutation => mutation_prob, :reproduction => reproduction_prob, :crossover => crossover_prob
  #(num_generations, tournament_size,  mutation_prob, reproduction_prob, crossover_prob)

  best = g.search(p, perfect, test_data)
  
  setup = ""
  setup += "A" if population_size == 30
  setup += "B" if population_size == 100
  setup += "C" if population_size == 1000
  setup += "A" if tournament_size == 1
  setup += "B" if tournament_size == 3
  setup += "C" if tournament_size == 7
  setup += "A" if crossover_prob == 0.9
  setup += "B" if crossover_prob == 0.4
  setup += "C" if crossover_prob == 0.0
  setup += "A" if num_generations == 10
  setup += "B" if num_generations == 50
  setup += "C" if num_generations == 250
  setup += "A" if max_tree_depth == 3
  setup += "B" if max_tree_depth == 4
  setup += "C" if max_tree_depth == 6

  print "SETUP[#{setup}]: (#{input})\n"
  print "BEST: #{best}\n\n"
  return [myFitness(perfect, best, test_data) , best]
end

def GetAverageTest(test)
  
end

tests = []
[30, 100, 1000].each { |population_size|
  [1, 3, 7].each { |tournament_size|
    [[0.9,0.1,0.0],[0.4,0.4,0.2],[0.0,1.0,0.0]].each { |operators|
      [10, 50, 250].each { |num_generations|
        [3, 4, 6].each { |max_tree_depth|
          params = {:num_generations => num_generations, :max_tree_depth => max_tree_depth,
                           :population_size => population_size, :tournament_size => tournament_size,
                           :crossover_prob => operators[0], :mutation_prob => operators[1], :reproduction_prob => operators[2]}
          tests.push({:params => params})
        }
      }
    }
  }
}

class GenerationalSearch
  def debug(s)
    print s
  end
end

tests.each { |t|
  runTest(t[:params])
}

