desc 'Demonstrate A-B recognition problem'
task :a_b_recognition do
  ABRecognitionDeliverable.new.dispatch
end

class ABRecognitionDeliverable
  require 'src/boolean_functions'
  require 'src/deliverable'
  include Deliverable
  
  def environment
    {
      :functions       => BooleanFunctions + [Plus, Subtract, Multiply, Divide],
      :terminals       => [Zero, PositiveOne] + AllVariables,
      :size            => 10,
      :maxdepth        => 8,
      :perfect         => lambda {|*input|
                            a_value = compare_arrays(letter_a, input).to_f
                            b_value = compare_arrays(letter_b, input).to_f
                            (a_value - b_value) * 3.125},
      :test_data       => (0...90).collect { rand_array(25) } + [letter_a, letter_b],
      # Generational Search
      :generations     => 3,
      :tournament_size => 3,
      :mutation        => 0.4,
      :reproduction    => 0.2,
      :crossover       => 0.4,
      # Rendering
      :title           => 'Deliverable 5b: A B Recognition',
      :filename        => 'deliverables/a_b_recognition.html'
    }
  end
  
  def letter_a
    [0,0,1,0,0,
     0,1,0,1,0,
     0,1,1,1,0,
     1,0,0,0,1,
     1,0,0,0,1]
  end
  
  def letter_b
    [1,1,1,1,0,
     1,0,0,0,1,
     1,1,1,1,0,
     1,0,0,0,1,
     1,1,1,1,0]
  end
  
  def compare_arrays(s,t)
    sum = 0
    s.zip(t){|a,b|
      sum += 1 if (a == b)
    }
    sum.to_f / s.size
  end
  
  def rand_array(length, max = 2)
    arr = []
    length.times{ arr << rand(max)}
    arr
  end
end