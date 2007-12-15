desc "Demonstrate search operators mutation, crossover, and reproduction"
task :search_operators do
  require 'src/population'
  
  @fitness_function = lambda {|params| ((params[0] ** 2)/2) + 1}

  @passes = []  
  10.times { @passes.push single_pass }
  
  render_search_operators
end

def single_pass
  originals = Population.new :size => 10
  originals.fitness_function = @fitness_function
  
  @successors = Population.new :size => 0
  @successors.fitness_function = @fitness_function
  
  fitnesses = []
  10.times {
    fitnesses.push mutate(originals)
    fitnesses.push crossover(originals)
  }
  
  return {:originals => originals, :successors => @successors, :fitnesses => fitnesses}
end

def mutate(population)
  original = population.random
  successor = original.mutate
  @successors.push successor
  
  return {
    :type => :mutation,
    :original => original.fitness(@fitness_function),
    :successor => successor.fitness(@fitness_function)
  }
end

def crossover(population)
  originals = []
  2.times { originals.push population.random }
  
  successors = originals[0].crossover(originals[1])
  @successors.push *successors
  
  original_fitnesses =  originals.collect  {|i| i.fitness @fitness_function }
  successor_fitnesses = successors.collect {|i| i.fitness @fitness_function }
  
  return {:type => :crossover, :original => original_fitnesses, :successor => successor_fitnesses}
end

def render_search_operators
  require 'erb'
  template = '<h2>Deliverable 2: Search Operators</h2>'
 
  @passes.each do |pass| 
    template << render_pass(pass) 
  end

  
  File.makedirs('deliverables')
  File.open('deliverables/search_operators.html', 'w') do |f|
    f << template
  end
end

def render_pass(pass)
  require 'erb'
  @pass = pass
  ret = %{
<h3>Pass</h3>
<h3>Fitnesses</h3>
<table>
<tr>
  <th>Type</th>
  <th>Original(s)</th>
  <th></th>
  <th>Successor(s)</th>
</tr>
}
  @pass[:fitnesses].each {|f|
    if f[:type] == :mutation
      ret << render_mutation(f)
    elsif f[:type] == :crossover
      ret << render_crossover(f)
    end
  }
  ret << %{
</table>
<h3>Statistics</h3>
<table>
<tr><th></th>
<th>Max Fitness</th>
<th>Min Fitness</th>
<th>Avg Fitness</th>
</tr>
<tr><th>Original</th>
<td>#{@pass[:originals].fitness_array.max}</td>
<td>#{@pass[:originals].fitness_array.min}</td>
<td>#{@pass[:originals].fitness_array.average}</td>
</tr><tr>
<th>Successor</th>
<td>#{@pass[:successors].fitness_array.max}</td>
<td>#{@pass[:successors].fitness_array.min}</td>
<td>#{@pass[:successors].fitness_array.average}</td>
</tr></table>
}
end

def render_mutation(fitness)
  case fitness[:successor] <=> fitness[:original]
  when 1
    valuation = "<span style='color:#00ff00'>Better<span>"
  when 0
    valuation = "<span style='color:#0000ff'>Equal<span>"
  when -1
    valuation = "<span style='color:#ff0000'>Worse<span>"
  end
%{
<tr>
<td>Mutation</td>
<td>#{fitness[:original]}</td><td></td>
<td>#{fitness[:successor]}</td><td></td>
<td>#{valuation}</td>
</tr>
}
end

def render_crossover(fitness)
case fitness[:successor].average <=> fitness[:original].average
when 1
  valuation = "<span style='color:#00ff00'>Better<span>"
when 0
  valuation = "<span style='color:#0000ff'>Equal<span>"
when -1
  valuation = "<span style='color:#ff0000'>Worse<span>"
end
%{
<tr>
<td>Crossover</td>
<td>#{fitness[:original][0]}</td>
<td>#{fitness[:original][1]}</td>
<td>#{fitness[:successor][0]}</td>
<td>#{fitness[:successor][1]}</td>
<td>#{valuation}<td>
</tr>
}
end