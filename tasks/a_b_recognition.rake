task :a_b_recognition do
  ABRecognitionDeliverable.dispatch
end

class ABRecognitionDeliverable
  require 'src/generational_search'
  require 'src/variable'
  require 'src/boolean_functions'
  require 'src/terminal'
    
  def self.letter_a
    [0,0,1,0,0,
     0,1,0,1,0,
     0,1,1,1,0,
     1,0,0,0,1,
     1,0,0,0,1]
  end
   
  def self.letter_b
    [0,1,1,0,0,
     0,1,0,1,0,
     0,1,1,1,0,
     0,1,0,0,1,
     0,1,1,1,0]
  end
  
  def self.dispatch
    require 'benchmark'
    results = []
    time = Benchmark.realtime {
      3.times {
        results << ABRecognitionDeliverable.test(ABRecognitionDeliverable.environment)
      }
    }

    ABRecognitionDeliverable.render(results, time)
  end
  
  def self.environment
    {
      :generations     => 3,
      :tournament_size => 3,
      :mutation        => 0.4,
      :reproduction    => 0.2,
      :crossover       => 0.4,
      :functions       => BooleanFunctions + [Plus, Subtract, Multiply, Divide],
      :terminals       => [Zero, PositiveOne] + AllVariables,
      :size            => 10,
      :maxdepth        => 8,
      :perfect         => lambda {|*input| diff = (compare_arrays(ABRecognitionDeliverable.letter_a, input) - compare_arrays(ABRecognitionDeliverable.letter_b, input)).to_f*3.125},
      :test_data       => (0...90).collect { rand_array(25) }
    }
  end
  
  def self.test(parameters)
    p = Population.new(parameters)
    g = GenerationalSearch.new(parameters)

    best = g.search(p, parameters[:perfect], parameters[:test_data])

    {:program => best, :fitness => best.fitness(parameters[:perfect], parameters[:test_data])}
  end
  
  
  def self.render(results, time)
    results.sort {|r,s| r[:fitness] <=> s[:fitness]}.reverse.each{|res|
      print "FITNESS(#{res[:fitness]})\n"
      print "BEST: #{res[:program]}\n\n"
    }
    total = results.inject(0) {|sum,res| sum + res[:fitness] }
    average = total/results.length
    print "Average: #{average}\n"
    print "Time: #{time}sec\n"
  end
  
  def self.rand_array(length, max = 2)
    arr = []
    length.times{ arr << rand(max)}
    arr
  end
  
  def self.compare_arrays(s,t)
    # print "s:#{s} t:#{t}\n"
    sum = 0
    s.zip(t){|a,b|
      sum += 1 if (a == b)
    }
    res = sum.to_f / s.size
    # print "#{res}\n"
    res
  end
end