require 'src/population'

describe Population do
  it "should default to a population of 30" do
    Population.new.length.should == 30
  end

  it "should create a population of 10" do
    Population.new({:size => 10}).length.should == 10
  end

  it "should default to a max depth of 4" do
    Population.new.each { |x| x.depth.should <= 4 }
  end
    
  it "should create a population of max depth 8" do
    Population.new({:maxdepth => 8}).each { |x| x.depth.should <= 8 }
  end
  
  it "should run fitness tests against all members" do
    p = Population.new
    p.fitness_function = PositiveOne.new
    p.each_index { |x| p.fitness_array[x].should be_a_kind_of(Numeric) }
  end

  it "should get a min fitness of one" do
    p = Population.new :functions => [Plus], :terminals => [PositiveOne], :size => 20, :maxdepth => 2
    p.fitness_function = PositiveThree.new
    p.fitness_array.min.should == 1
  end
  
  it "should get a max fitness of four" do
    p = Population.new :functions => [Plus], :terminals => [PositiveOne], :size => 20, :maxdepth => 2
    p.fitness_function = PositiveThree.new
    p.fitness_array.max.should == 4
  end
  
  it "should get an average between 1 and 4" do
    p = Population.new :functions => [Plus], :terminals => [PositiveOne], :size => 20, :maxdepth => 2
    p.fitness_function = PositiveThree.new
    
    p.fitness_array.min.should == 1
    p.fitness_array.average.should >= 1
    p.fitness_array.average.should <= 4
  end
end