require 'src/program'

describe "Function representations" do
  it "should add terminals" do
    program = Plus.new([PositiveOne.new, PositiveOne.new])
    program.call.should == 2
  end
  
  it "should subtract terminals" do
    program = Subtract.new([PositiveOne.new, PositiveOne.new])
    program.call.should == 0
  end
  
  it "should multiply terminals" do
    program = Multiply.new([PositiveTwo.new, PositiveTwo.new])
    program.call.should == 4
  end
  
  it "should take the modulus of terminals" do
    program = Modulus.new([PositiveFive.new, PositiveTwo.new])
    program.call.should == 1
  end

  it "should return zero when taking the modulus by zero" do
    program = Modulus.new([PositiveFour.new, Zero.new])
    program.call.should == 0
  end
  
  it "should divide terminals" do
    program = Divide.new([PositiveFour.new, PositiveTwo.new])
    program.call.should == 2
  end
  
  it "should return zero when dividing by zero" do
    program = Divide.new([PositiveFour.new, Zero.new])
    program.call.should == 0
  end
end

describe "children management" do
  it "should know when it has too few kids" do
    program = Divide.new([Zero.new])
    program.too_many_kids?.should == false
    program.valid_kids?.should == false
    program.too_few_kids?.should == true
  end
  
  it "should know when it has enough kids" do
    program = Divide.new([Zero.new, Zero.new])
    program.too_many_kids?.should == false
    program.valid_kids?.should == true
    program.too_few_kids?.should == false
  end

  it "should know when it has too many kids" do
    program = Divide.new([Zero.new, Zero.new, Zero.new])
    program.too_many_kids?.should == true
    program.valid_kids?.should == false
    program.too_few_kids?.should == false
  end
end

describe "Parent-Child Relationships" do
  it "should know if it's the root" do
    program = Divide.new([Zero.new,Zero.new])
    program.root?.should == true
  end
  
  it "should know it's not a root" do
    child = Zero.new
    program = Divide.new([child,Zero.new])
    child.root?.should == false
  end
end