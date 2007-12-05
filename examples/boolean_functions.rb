require 'src/terminal'
require 'src/boolean_functions'
require 'src/boolean_terminals'

describe "Boolean Functions" do
  # And
  it "should be true when anding trues" do
    program = And.new([True.new, True.new])
    program.call.should == 1
  end

  it "should be false when anding true and false" do
    program = And.new([True.new, False.new])
    program.call.should == 0
  end
  
  it "should be false when anding falses" do
    program = And.new([False.new, False.new])
    program.call.should == 0
  end
  # Or
  it "should be false when oring true and false" do
    program = Or.new([True.new, True.new])
    program.call.should == 1
  end
  
  it "should be false when anding falses" do
    program = Or.new([True.new, False.new])
    program.call.should == 1
  end
  
  it "should be true when anding trues" do
    program = Or.new([False.new, False.new])
    program.call.should == 0
  end
  
  # Xor
  it "should be false when xoring trues" do
    program = Xor.new([True.new, True.new])
    program.call.should == 0
  end
  
  it "should be true when xoring true and false" do
    program = Xor.new([True.new, False.new])
    program.call.should == 1
  end
  
  it "should be false when xoring falses" do
    program = Xor.new([False.new, False.new])
    program.call.should == 0
  end
  
  # Not
  it "should be false when noting true" do
    program = Not.new([True.new])
    program.call.should == 0
  end
  
  it "should be true when anding trues" do
    program = Not.new([False.new])
    program.call.should == 1
  end


end