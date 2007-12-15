desc 'Demonstrate the even-odd recognition problem'
task :even_odd do
  EvenOddDeliverable.new.dispatch
end

class EvenOddDeliverable
  require 'src/deliverable'
  include Deliverable
  
  def environment
    num_points = 40
    {
      # Population
      :functions       => [Plus, Subtract, Multiply, Divide],
      :terminals       => Terminals+[VariableZero, VariableZero, VariableZero],
      :size            => 10,
      :maxdepth        => 4,
      :perfect         => lambda {|j| j%2 },
      :test_data       => (-num_points/2)..(num_points/2),
      # Generational Search
      :generations     => 4,
      :tournament_size => 3,
      :mutation        => 0.6,
      :reproduction    => 0.1,
      :crossover       => 0.3,
      # Rendering
      :title           => 'Deliverable 5c: Regression',
      :filename        => 'deliverables/regression.html'
    }
  end
end