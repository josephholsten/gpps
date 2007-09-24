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