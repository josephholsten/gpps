desc 'Demonstrate the function regression problem'
task :regression do
  RegressionDeliverable.new.dispatch
end

class RegressionDeliverable
  require 'src/generational_search'
  require 'src/variable'
  require 'src/regression_function'
  require 'src/deliverable'
  include Deliverable
  def dispatch
    parameters = environment

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
      results << run_test(historical)
    }
    render(:results => results)
  end
  
  def environment
    {
      # Population
      # Using some non-standard functions in the mix
      :functions       => [Logarithm, Parabola, StraightLine, Multiply, Divide, Plus, Subtract, Squared, Cubed],
      :terminals       => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero, VariableZero],
      :size            => 10,
      :maxdepth        => 4,
      # Generational Search
      :generations     => 200,
      :tournament_size => 3,
      :mutation        => 0.311,
      :reproduction    => 0.532,
      :crossover       => 0.155,
      # Rendering
      :title           => 'Deliverable 5c: Regression',
      :filename        => 'deliverables/regression.html'
    }
  end
  
  def run_test(historical, parameters = environment)
    parameters[:test_data] = historical.keys.sort
    parameters[:perfect] = lambda {|j| historical[j] }

    test(parameters)
  end
end
