require 'src/population'

class GenerationalSearch
  def initialize(num_generations=nil, tournament_size=nil, mutation_prob=nil, reproduction_prob=nil, crossover_prob=nil)
    #defaults
    @probibilities = { :mutation => 0.4, :reproduction =>  0.2, :crossover => 0.4 }
    @num_generations = 50
    @tournament_size = 3
    
    #overrides
    @num_generations = num_generations if !num_generations.nil?
    @tournament_size = tournament_size if !tournament_size.nil?
    if !mutation_prob.nil? && !reproduction_prob.nil? && !crossover_prob.nil?
      t = mutation_prob + reproduction_prob + crossover_prob
      @probibilities = { :mutation => (mutation_prob/t), :reproduction => (reproduction_prob/t), :crossover => (crossover_prob/t) }
    end
  end
  
  #NOTE: If a crossover operator is selected as the last operator in
  # creating a new generation then the generation size could increase by one
  def search(population, fitness_against, test_data, generation_num=nil)
    generation_num = @num_generations if generation_num.nil?

    # If this is the last generation OR if a perfect match has been found then return the best match found
    population.fitnessAgainst(fitness_against, test_data)
    min = population.fitnessArray.min
    if min== 0 || generation_num == 0
      population.each_index{ |x| return population[x] if population.fitnessArray[x]==min }
    end
    
    # Create a new array
    newpopulation = Array.new
    
    # Populate the new population using mutations on selected individuals
    while newpopulation.length < population.size
      p = rand
      # so you could do this as Probabilities[:mutation], etc
      if p < @probibilities[:mutation] #Mutate
        newpopulation.push(get_random_individual(population).mutate(population.functions, population.terminals, population.maxdepth) )
      elsif p < @probibilities[:mutation]+@probibilities[:reproduction]
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
    indiv = []
    fitness = []
    (1..tournament).each { 
      x = rand(population.length)
      indiv.push(population[x]) 
      fitness.push(population.fitnessArray[x])
    }
    min_fitness = fitness.min
    indiv.each_index { |x| return indiv[x] if fitness[x] == min_fitness }
    
    return indiv.random #should never get here
  end
  
  def get_random_crossover(population)
    first_individual = population.random
    second_individual = population.random
    
    (newone, newtwo) = first_individual.crossover(second_individual)
    
    if newone.depth > population.maxdepth || newtwo.depth > population.maxdepth
      return get_random_crossover(population) #try again
    else
      return [newone, newtwo]
    end
  end
end
