task :regression do
  RegressionDeliverable.dispatch
end

class RegressionDeliverable
  require 'src/generational_search'
  require 'src/variable'
  require 'src/regression_function'
  def self.dispatch
    parameters = RegressionDeliverable.environment

    results = []
    historicals = [
      # Approximatly exponential
      { 1 => 36, 2 => 39, 3 => 35, 4 => 41, 6 => 65, 8 => 80, 10 => 120, 11=> 122, 14 => 235},
      # Approximatly linear
      { 1 => 38, 2 => 52, 5 => 78, 6 => 83, 8 => 111, 9 => 125, 10 => 125, 16=> 178, 17 => 166},
      # Approximatly logarithmic
      { 1 => 30, 2 => 69, 3 => 90, 4 => 105, 6 => 111, 8 => 126, 10 => 111, 11=> 120, 14 => 126, 19 =>128}
    ]
    
    historicals.each{|historical|
      results << RegressionDeliverable.run_test(historical)
    }
    RegressionDeliverable.render(results)
  end
  
  def self.environment
    {
      :generations     => 200,
      :tournament_size => 3,
      :mutation        => 0.311,
      :reproduction    => 0.532,
      :crossover       => 0.155,
      # Using some non-standard functions in the mix
      :functions       => [Logarithm, Parabola, StraightLine, Multiply, Divide, Plus, Subtract, Squared, Cubed],
      :terminals       => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero, VariableZero],
      :size            => 10,
      :maxdepth        => 4,
    }
  end
  
  def self.run_test(historical, parameters = environment)

    parameters[:test_data] = historical.keys.sort

    # Generate the *perfect* function based on known values

    # Beautiful, but kinda evil
    # perfect_eval =   "lambda {|j| \n"
    # historical.each { |size, time| perfect_eval += "return #{time} if j==#{size}\n" }
    # perfect_eval += "}\n"
    # perfect = eval(perfect_eval)

    parameters[:perfect] = lambda {|j| historical[j] }

    RegressionDeliverable.test(parameters)
  end
  
  def self.test(parameters)
    require 'src/generational_search'
    p = Population.new(parameters)
    g = GenerationalSearch.new(parameters)

    best = g.search(p, parameters[:perfect], parameters[:test_data])

    {:program => best, :fitness => best.fitness(parameters[:perfect], parameters[:test_data])}
  end
  
  def self.render(results, time = nil)
    # render_regression(results)
    results.each{|res|
      print "FITNESS(#{res[:fitness]})\n"
      print "BEST: #{res[:program]}\n\n"
    }
    print "Time: #{time}sec\n" if time
  end
end