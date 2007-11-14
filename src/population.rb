require 'src/program'
require 'src/custom_methods'

class Population < Array
  attr_reader :functions
  attr_reader :terminals
  attr_reader :size
  attr_reader :maxdepth
  attr_accessor :fitness_function
  attr_accessor :test_data

  def initialize(params = {})
    #if we have really been passed another population just pull it's variables and dont generate a random population
    if params.respond_to?("fitness_against")
      @functions = params.functions
      @terminals = params.terminals
      @size      = params.size
      @maxdepth  = params.maxdepth
      return self
    end
    @functions        = params[:functions]    || Functions
    @terminals        = params[:terminals]    || Terminals + Variables
    @size             = params[:size]         || 30
    @maxdepth         = params[:maxdepth]     || 4
    @test_data        = params[:test_data]    || (0..5)
    @fitness_function = params[:fitness_function]
    
    @size.times {|i|
      self.push( Program.generate(@functions, @terminals, rand(@maxdepth)+1) )
    }
  end
  
  def fitness_array
    @fitness_array = render_fitness! unless fitness_rendered?
    @fitness_array
  end
  
  def erase()
    self.clear
    @fitness_rendered_flag = false
    @fitnessArray = []
  end
  
  private
  def fitness_rendered?    
    @fitness_rendered_flag
  end
  
  def render_fitness!
    @fitness_rendered_flag = true
    
    self.collect {|i|
      i.fitness(@fitness_function, @test_data)
    }
  end
end
