task :generational_search do
  require 'src/generational_search'
  
  @test_data = -5..5  # has jonyer said anything about what this default should be?
  @perfect = lambda {|j| (((1.0*j) ** 2) * 0.5) + 1}
  #perfect = lambda {|j| ((1.0*j) ** 6) -(2.0*((1.0*j)**4)) + ((1.0*j)**2) }  # (x**6 - 2x**4 + x**2)

  p = Population.new :size => 100, :maxdepth => 4
  # I know we shouldn't need to but it helps quiet a bit if we trim down the number of terminals
  # p = Population.new :functions => [Multiply, Divide, Plus],
  #                    :terminals => [PositiveOne, PositiveTwo, PositiveThree, PositiveFour, PositiveFive, VariableZero],
  #                    :size => 100,
  #                    :maxdepth => 4
  
  g = GenerationalSearch.new :generations => 50,
                             :tournament_size => 3,
                             :mutation => 0.4,
                             :reproduction => 0.2,
                             :crossover => 0.4

  @best = g.search(p, @perfect, @test_data)
  
  render_generational_search
end

def render_generational_search
  require 'erb'
  template = %{\
<h2>Deliverable 3: Generational Search</h2>
<dl>
<dt>Fitness</dt><dd><%= @best.fitness @perfect, @test_data %></dd>
<dt>Best</dt><dd><%= @best %></dd>
</dl>
}
  
  File.open('deliverables/generational_search.html', 'w') do |f|
    f << ERB.new(template).result
  end
end