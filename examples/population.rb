require 'src/population'

describe Population do
  it "should default to a population of 30" do
    Population.new.length.should == 30
  end

  it "should create a population of 10" do
    Population.new(Functions, Terminals + Variables, 10).length.should == 10
  end

  it "should default to a max depth of 4" do
    Population.new(Functions, Terminals + Variables, 100).each { |x| x[:program].depth.should <= 4 }
  end
    
  it "should create a population of max depth 8" do
    Population.new(Functions, Terminals + Variables, 100, 8).each { |x| x[:program].depth.should <= 8 }
  end
  
  it "should run fitness tests against all members" do
    Population.new.fitnessAgainst(PositiveOne.new).each { |x| x[:fitness].should be_a_kind_of(Numeric) }
  end

  it "should get a min fitness of one" do
    Population.new([Plus], [PositiveOne], 20, 2).fitnessAgainst(PositiveThree.new).fitnessArray.min.should == 1
  end
  
  it "should get a max fitness of four" do
    Population.new([Plus], [PositiveOne], 20, 2).fitnessAgainst(PositiveThree.new).fitnessArray.max.should == 4
  end
  
  it "should get an average between 1 and 4" do
    i = Population.new([Plus], [PositiveOne],20, 2).fitnessAgainst(PositiveThree.new).fitnessArray.average
    i.should >= 1
    i.should <= 4
  end    
end