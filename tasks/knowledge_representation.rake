desc "Demonstrate the genetic programming knowledge representation"
task :knowledge_representation do
  require 'src/population'
  p = Population.new
  p.fitness_function = lambda {|params| ((params[0] ** 2)/2) + 1}
  @fitnesses = p.fitness_array.sort
  
  render_knowledge_representation
end

def render_knowledge_representation
  require 'erb'
  template = %{\
<h2>Deliverable 1: Knowledge Representation</h2>
 
<h3>Fitnesses</h3>
<ul>
<% @fitnesses.each do |f| %>
  <li><%= f %></li>
<% end %>
</ul>

<h3>Summary</h3>
<dl>
  <dt>Max Fitness</dt>
  <dd><%= @fitnesses.max %></dd>
  <dt>Min Fitness</dt>
  <dd><%= @fitnesses.min %></dd>
  <dt>Avg Fitness</dt>
  <dd><%= @fitnesses.average %></dd>
</dl>
}
  File.makedirs('deliverables')
  File.open('deliverables/knowledge_representation.html', 'w') do |f|
    f << ERB.new(template).result
  end
end