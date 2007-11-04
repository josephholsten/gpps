require 'src/program'
require 'src/custom_methods'

class Population < Array
  attr_reader :fitnessArray
  attr_reader :functions
  attr_reader :terminals
  attr_reader :size
  attr_reader :maxdepth

  def initialize(functions = Functions, terminals = Terminals+Variables, size = 30, maxdepth = 4)
    #if we have really been passed another population just pull it's variables and dont generate a random population
    if functions.respond_to?("fitnessAgainst")
      @functions = functions.functions
      @terminals = functions.terminals
      @size = functions.size
      @maxdepth = functions.maxdepth
      return self
    end
    
    @functions = functions
    @terminals = terminals
    @size = size
    @maxdepth = maxdepth
    
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