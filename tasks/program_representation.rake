task :program_representation do
  require 'src/generational_search'
  
  num_points = 200
  common_test = {
    # I know we shouldn't need to but it helps quiet a bit if we trim down the number of terminals
    :functions => Functions,
    #:functions => [Multiply, Plus],
    # :terminals => Terminals + [VariableZero],
    # :terminals => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero],
    :terminals => [PositiveOne, VariableZero],
    
    :test_data => (0..num_points).collect { |x| -5.0 + (((x*1.0))/(num_points/10))},

    # :perfect => lambda {|j| (((1.0*j) ** 2) * 0.5) + 1},
    :perfect => lambda {|j| ((1.0*j) ** 6) -(2.0*((1.0*j)**4)) + ((1.0*j)**2) },  # (x**6 - 2x**4 + x**2)
  }
  
  tests = []
  [30, 100, 1000].each { |population_size|
    [1, 3, 7].each { |tournament_size|
      [[0.9,0.1,0.0],[0.4,0.4,0.2],[0.0,1.0,0.0]].each { |operators|
        [10, 50, 250].each { |num_generations|
          [3, 4, 6].each { |max_tree_depth|
            tests << {
              :generations => num_generations,
              :max_tree_depth => max_tree_depth,
              :population_size => population_size,
              :tournament_size => tournament_size,
              :crossover => operators[0],
              :mutation => operators[1],
              :reproduction => operators[2]
            }
  } } } } }
  tests.each {|t|
    program = run_program_representation_test(common_test.merge(t))
    render_program_represetation(t, program)
  }
end

def run_program_representation_test(parameters)
  p = Population.new(parameters)
  g = GenerationalSearch.new(parameters)
  g.debug_mode = true
  best = g.search(p, parameters[:perfect], parameters[:test_data])
  
  {:program => best, :fitness => best.fitness(parameters[:perfect], parameters[:test_data])}
end

def render_program_represetation(params, program)
  setup = ""  
  setup << "A" if params[:population_size] == 30
  setup << "B" if params[:population_size] == 100
  setup << "C" if params[:population_size] == 1000
  
  setup << "A" if params[:tournament_size] == 1
  setup << "B" if params[:tournament_size] == 3
  setup << "C" if params[:tournament_size] == 7
  
  setup << "A" if params[:crossover] == 0.9
  setup << "B" if params[:crossover] == 0.4
  setup << "C" if params[:crossover] == 0.0
  
  setup << "A" if params[:generations] == 10
  setup << "B" if params[:generations] == 50
  setup << "C" if params[:generations] == 250
  
  setup << "A" if params[:max_tree_depth] == 3
  setup << "B" if params[:max_tree_depth] == 4
  setup << "C" if params[:max_tree_depth] == 6

  print "SETUP[#{setup}]: (#{params})\n"
  print "BEST: #{program[:program]} : #{program[:fitness]}\n\n"
end

