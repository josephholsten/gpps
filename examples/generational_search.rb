require 'src/generational_search'

describe GenerationalSearch do
  it "should return a perfect match" do
    p = Population.new([Plus], [PositiveOne], 1, 1)
    GenerationalSearch.new.search(p, PositiveOne.new, nil, 0).class.should == PositiveOne
  end

  it "should return the best match found" do
    #this is a non-deterministic test but the chances of it failing are so small
    p = Population.new([Plus], [PositiveOne], 300, 2) #should be an array of ("1" or "1+1")
    GenerationalSearch.new.search(p, PositiveThree.new, nil, 0).call.should == 2
  end
  
  it "should return the best match found" do
    #this is a non-deterministic test but the chances of it failing are so small
    p = Population.new([Plus], [PositiveOne], 300, 2) #should be an array of ("1" or "1+1")
    GenerationalSearch.new.search(p, PositiveThree.new, nil,3).call.should == 2
  end
  
  it "should return a match of two from the tournament" do
    p = Population.new([Plus], [PositiveOne], 300, 2) #should be an array of ("1" or "1+1")
    p.fitnessAgainst(PositiveThree.new)
    GenerationalSearch.new.get_random_individual(p, 50).call.should == 2
  end
end