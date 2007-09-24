require 'src/program'
require 'src/customMethods'

class Population < Array
  def initialize(functions = Functions, terminals = Terminals+Variables, size = 30, maxdepth = 4)
    1.upto(size) { |i|
      self.push( { :program => Program.generate(functions, terminals, rand(maxdepth)+1) })
    }
  end
  
  def fitnessAgainst(expected_program, test_data = nil)
    self.each_index { |p|
      self[p][:fitness] = Program.fitness(expected_program, self[p][:program], test_data)
    }
  end
  
  def fitnessArray()
    self.collect { |p| p[:fitness] }
  end
end

# Final portion for deliverable1
if __FILE__ == $0
    p = Population.new()
    p.fitnessAgainst(lambda {|params| ((params[0] ** 2)/2) + 1})
    
    a = p.fitnessArray().sort
    a.each { |f| print "Fitness(#{f})\n" }
    print "Max Fitness(#{a.max})\n"
    print "Min Fitness(#{a.min})\n"
    print "Avg Fitness(#{a.average})\n\n"
end
