require 'src/generational_search'

describe GenerationalSearch do
  it "should return a perfect match" do
    p = Population.new :functions => [Plus],
                       :terminals => [PositiveOne],
                       :size => 1,
                       :maxdepth => 1
    GenerationalSearch.new.search(p, PositiveOne.new, [[1],[2],[3],[4],[5]], 0).class.should == PositiveOne
  end

  it "should return the best match found" do
    #this is a non-deterministic test but the chances of it failing are so small
    #should be an array of ("1" or "1+1")
    p = Population.new :functions => [Plus],
                       :terminals => [PositiveOne],
                       :size => 300,
                       :maxdepth => 2
    GenerationalSearch.new.search(p, PositiveThree.new, [[1],[2],[3],[4],[5]], 0).call.should == 2
  end
  
  it "should return a match of two from the tournament" do
    #should be an array of ("1" or "1+1")
    p = Population.new :functions => [Plus],
                       :terminals => [PositiveOne],
                       :size => 300,
                       :maxdepth => 2
    p.fitness_function = PositiveThree.new
    GenerationalSearch.new.get_random_individual(p, 50).call.should == 2
  end
  it "should return the best match found with variable" do
    #this is a non-deterministic test but the chances of it failing are so small
    #should be an array of ("1" or "1+1")
    p = Population.new :functions => [Plus],
                       :terminals => [VariableZero],
                       :size => 300,
                       :maxdepth => 2
    GenerationalSearch.new.search(p, PositiveThree.new, [[1],[2],[3],[4],[5]], 0).call(1).should == 1
  end
  
  it "should return the best match found with variable" do
    #this is a non-deterministic test but the chances of it failing are so small
    #should be an array of ("1" or "1+1")
    p = Population.new :functions => [Plus],
                       :terminals => [VariableZero],
                       :size => 300,
                       :maxdepth => 2
    GenerationalSearch.new.search(p, PositiveThree.new, [[1,1],[2,2],[3,3],[4,4],[5,5]], 0).call(1,2,3).should == 1
  end
end