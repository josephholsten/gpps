desc "Demonstrate generational search"
task :generational_search do
  require 'src/generational_search'
  require 'src/variable'
  
  @test_data = -20..20  # has jonyer said anything about what this default should be?
  @perfect = lambda {|j| i = j.to_f; ((i ** 2) * 0.5) + 1}
  #perfect = lambda {|j| i = j.to_f; i ** 6 -(i**4)*2 + i**2 }  # (x**6 - 2x**4 + x**2)
  parameters = {
    # Population
    :size            => 100,
    :maxdepth        => 4,
    :functions       => [Multiply, Divide, Plus],
    :terminals       => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero, VariableZero],
    # Search
    :generations     => 100,
    :tournament_size => 3,
    :mutation        => 0.4,
    :reproduction    => 0.2,
    :crossover       => 0.4,
    :perfect         => lambda {|j| i = j.to_f; ((i ** 2) * 0.5) + 1},
    :test_data       => (-20..20)
  }
  
  
  # p = Population.new :size => 100, :maxdepth => 4
  # I know we shouldn't need to but it helps quiet a bit if we trim down the number of terminals
  # p = Population.new :functions => [Multiply, Divide, Plus],
  #                    :terminals => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero],
  #                    :size => 100,
  #                    :maxdepth => 4
  # 
  # g = GenerationalSearch.new :generations => 50,
  #                                :tournament_size => 3,
  #                                :mutation => 0.4,
  #                                :reproduction => 0.2,
  #                                :crossover => 0.4

  # prog = g.search(p, @perfect, @test_data)
  
  prog = test_generational_search(parameters)
  
  render_generational_search prog
end
def test_generational_search(parameters)
  p = Population.new(parameters)
  g = GenerationalSearch.new(parameters)

  best = g.search(p, parameters[:perfect], parameters[:test_data])
  
  {:program => best, :fitness => best.fitness(parameters[:perfect], parameters[:test_data])}
end

def render_generational_search(prog)
  require 'erb'
  template = "
<h2>Deliverable 3: Generational Search</h2>
<dl>
<dt>Fitness</dt><dd>#{prog[:fitness]}</dd>
<dt>Best</dt><dd>#{prog[:best]}</dd>
</dl>
"
  
  File.makedirs('deliverables')
  File.open('deliverables/generational_search.html', 'w') do |f|
    # f << ERB.new(template).result
    f << template
  end
end