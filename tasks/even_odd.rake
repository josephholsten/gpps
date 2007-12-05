task :even_odd do
  EvenOddDeliverable.dispatch
end

class EvenOddDeliverable
  require 'src/generational_search'
  require 'src/variable'
  require 'benchmark'

  def self.dispatch
    results = []
    time = Benchmark.realtime {
      10.times {
        results << EvenOddDeliverable.test(EvenOddDeliverable.environment)
      }
    }

    EvenOddDeliverable.render(results, time)
  end
  
  def self.environment
    num_points = 40
    {
      :generations     => 4,
      :tournament_size => 3,
      :mutation        => 0.6,
      :reproduction    => 0.1,
      :crossover       => 0.3,
      :functions       => [Plus, Subtract, Multiply, Divide],
      :terminals       => Terminals+[VariableZero, VariableZero, VariableZero],
      :size            => 10,
      :maxdepth        => 4,
      :perfect         => lambda {|j| j%2 },
      :test_data       => (-num_points/2)..(num_points/2)
    }
  end
  
  def self.test(parameters)
    p = Population.new(parameters)
    g = GenerationalSearch.new(parameters)

    best = g.search(p, parameters[:perfect], parameters[:test_data])

    {:program => best, :fitness => best.fitness(parameters[:perfect], parameters[:test_data])}
  end
  
  def self.render(results, time)
    results.each{|res|
      print "FITNESS(#{res[:fitness]})\n"
      print "BEST: #{res[:program]}\n\n"
    }
    print "Time: #{time}sec\n"
  end
end