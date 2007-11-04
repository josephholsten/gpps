require 'src/population'

class GenerationalSearch
  # perhaps instead:
  Probibilities = { :mutation => 0.4, :reproduction =>  0.2, :crossover => 0.4 }
  
  #NOTE: If a crossover operator is selected as the last operator in
  # creating a new generation then the generation size could increase by one
  def search(population, fitness_against, test_data, generation_num)
    # If this is the last generation OR if a perfect match has been found then return the best match found
    population.fitnessAgainst(fitness_against, test_data)
    min = population.fitnessArray.min
    if min== 0 || generation_num == 0
      population.each_index{ |x| return population[x] if population.fitnessArray[x]==min }
    end
    
    # Create a new (empty) population array
    newpopulation = Population.new(population)
    
    # Populate the new population using mutations on selected individuals
    while newpopulation.length < newpopulation.size
      p = rand
      # so you could do this as Probabilities[:mutation], etc
      if p < Probibilities[:mutation] #Mutate
        newpopulation.push(get_random_individual(population).mutate(newpopulation.functions, newpopulation.terminals, newpopulation.maxdepth) )
      elsif p < Probibilities[:mutation]+Probibilities[:reproduction]
        newpopulation.push(get_random_individual(population).clone)
      else #Crossover
        (new1, new2) = get_random_crossover(population)
        newpopulation.push(new1, new2)
      end
    end
    
    return search(newpopulation, fitness_against, test_data, generation_num-1)
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
