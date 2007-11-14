require 'src/population'

class GenerationalSearch
  def debug(s)
  end
  
  def initialize(params = {})
    @probabilities = {}
    
    @num_generations = params[:generations]     || 50
    @tournament_size = params[:tournament_size] || 3
    
    @probabilities[:mutation]     = params[:mutation]     || 0.4
    @probabilities[:reproduction] = params[:reproduction] || 0.2
    @probabilities[:crossover]    = params[:crossover]    || 0.4
    normalize_probabilities
  end
  
  #NOTE: If a crossover operator is selected as the last operator in
  # creating a new generation then the generation size could increase by one
  def search(population, fitness_against, test_data, generation_num=nil)
    generation_num = @num_generations if generation_num.nil?

    # If this is the last generation OR if a perfect match has been found then return the best match foundsrc="/images/about_files
    population.fitness_function = fitness_against
    population.test_data = test_data
    debug("MIN(#{population.fitness_array.min}) AVG(#{population.fitness_array.average}) MAX(#{population.fitness_array.max})\n")
    min = population.fitness_array.min
    
    if min == 0 || generation_num == 0
      population.each_index{ |x| return population[x] if population.fitness_array[x]==min }
    end
    
    # Create a new array
    newpopulation = Array.new
    
    # Populate the new population using mutations on selected individuals
    while newpopulation.length < population.size
      p = rand
      # so you could do this as Probabilities[:mutation], etc
      if p < @probabilities[:mutation] #Mutate
        newpopulation.push(get_random_individual(population).mutate(population.functions, population.terminals, population.maxdepth) )
      elsif p < @probabilities[:mutation]+@probabilities[:reproduction]
        newpopulation.push(get_random_individual(population).clone)
      else #Crossover
        (new1, new2) = get_random_crossover(population)
        newpopulation.push(new1, new2)
      end
    end
    
    # Erase the old population and copy the new data into it. 
    #(slower but the way it was we were putting a new population object on the stack for each generation, bad for 150+ generations)
    population.erase
    newpopulation.each { |p| population.push(p) }
    newpopulation.clear
    return search(population, fitness_against, test_data, generation_num-1)
  end

  #tournament selection
  def get_random_individual(population, tournament=3)
    individuals = []
    tournament.times {
      individuals.push population.random
    }
    
    individuals.min {|i,j| i.fitness(population.fitness_function) <=> j.fitness(population.fitness_function)}
  end
  
  def get_random_crossover(population)
    first_individual = population.random
    second_individual = population.random
    
    (newone, newtwo) = first_individual.crossover(second_individual)
    
    if newone.depth > population.maxdepth || newtwo.depth > population.maxdepth
      # new individuals have too large of a depth
      # we should try again
      return get_random_crossover(population) 
    else
      return [newone, newtwo]
    end
  end
  
  private
  def normalize_probabilities
    t = @probabilities[:mutation] +  @probabilities[:reproduction] + @probabilities[:crossover]
    @probabilities = { :mutation => (@probabilities[:mutation]/t),
                       :reproduction => ( @probabilities[:reproduction]/t),
                       :crossover => (@probabilities[:crossover]/t) }
  end
end
