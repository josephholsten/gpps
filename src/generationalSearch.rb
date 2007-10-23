require 'src/population'

class GenerationalSearch
  Probibilities = [ 0.3,  0.3, 0.4 ] #Mutate/Reproduce/Crossover
  
  #NOTE: If a crossover operator is selected as the last operator in creating a new generation then the generation size could increase by one
  def search(population, fitnessAgainst, testData, generationNum)
    # Evaluate the fitnesses and check for a perfect match
    population.fitnessAgainst(fitnessAgainst, testData)
    min = population.fitnessArray.min
    if min== 0
      population.each{ |indiv| return indiv[:program] if indiv[:fitness]==0 }
    end
    
    # If this is the last generation then return the best match found
    if generationNum == 0
      population.each{ |indiv| return indiv[:program] if indiv[:fitness]==min } 
    end
    
    # Generate a new population
    newpopulation = Population.new(nil)
    
    # Populate the new population using mutations on selected individuals
    while newpopulation.length < population.length
      p = rand
      if p < Probibilities[0] #Mutate
        newIndiv = getRandomIndividual(population).clone
        individualMutate!(newIndiv)
        newpopulation.push(newIndiv)
      elsif p < Probibilities[0]+Probibilities[1] #Reproduce
        newIndiv = getRandomIndividual(population).clone
        individualReproduce!(newIndiv)
        newpopulation.push(newIndiv)
      else #Crossover
        newIndiv1 = getRandomIndividual(population).clone
        newIndiv2 = getRandomIndividual(population).clone
        individualCrossover!(newIndiv1, newIndiv2)
        newpopulation.push(newIndiv1, newIndiv2)
      end
    end
    
    return search(newpopulation, fitnessAgainst, testData, generationNum-1)
  end
  
  #random selection
  #def getRandomIndividual(population)
  #  return population.random
  #end
  
  #tournament selection
  def getRandomIndividual(population, tournament=3)
    indiv = []
    (0..tournament).each { indiv.push(population.random) }
    minFitness = indiv.collect{ |x| x[:fitness] }.min
    indiv.each { |i| return i if i[:fitness] == minFitness }
    
    return indiv.ramdom #should never get here
  end
  
  def individualMutate!(program)
  end
  
  def individualReproduce!(program)
  end
  
  def individualCrossover!(program1, program2)
  end
end