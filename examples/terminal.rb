require 'src/terminal'

describe "Terminal representations" do
  it "should represent negative five" do
    NegativeFive.new.call.should == -5
  end
  
  it "should represent negative four" do
    NegativeFour.new.call.should == -4
  end
  
  it "should represent negative three" do
    NegativeThree.new.call.should == -3
  end
  
  it "should represent negative two" do
    NegativeTwo.new.call.should == -2
  end
  
  it "should represent negative one" do
    NegativeOne.new.call.should == -1
  end
  
  it "should represent zero" do
    Zero.new.call.should == 0
  end
  
  it "should represent one" do
   PositiveOne.new.call.should == 1
  end
  
  it "should represent two" do
   PositiveTwo.new.call.should == 2
  end
  
  it "should represent three" do
   PositiveThree.new.call.should == 3
  end
  
  it "should represent four" do
    PositiveFour.new.call.should == 4
  end
  
  it "should represent five" do
    PositiveFive.new.call.should == 5
  end

  it "should have depth one" do
    Zero.new.depth.should == 1
  end
  
  it "should have a size one" do
    Zero.new.size.should == 1
  end
  
  it "should have string representation" do
    NegativeFive.new.to_s.should == "-5"
  end
  
  it "should have a string representations for a variable" do
    VariableZero.new.to_s.should == "x"
  end
end

describe "Constant" do
  it "should not be effected by parameters" do
    const = PositiveOne.new
    const.call(1).should == 1
    const.call(2).should == 1
  end
  
  it "should have arty 0" do
    const = PositiveOne.new
    const.arity.should == 0
  end
    
end

describe "Variable" do
  
  it "should return variable on call" do
    VariableZero.new.call(10, 20, 30).should == 10
  end
end