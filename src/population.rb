require 'src/program'
require 'src/customMethods'

class Population < Array
  attr_reader :fitnessArray
  
  def initialize(functions = Functions, terminals = Terminals+Variables, size = 30, maxdepth = 4)
    return if functions.nil?
    
    1.upto(size) { |i|
      self.push( Program.generate(functions, terminals, rand(maxdepth)+1) )
    }
  end
  
  def fitnessAgainst(expected_program, test_data = nil)
    @fitnessArray = []
    self.each_index { |x|
      @fitnessArray[x] = Program.fitness(expected_program, self[x], test_data)
    }
  end
end