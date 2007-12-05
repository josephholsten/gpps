require 'src/terminal'

describe "Constant representations" do
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
end

describe "Constant" do
  before :each do
    @const = PositiveOne.new
  end
  
  it "should not be effected by parameters on call" do
    @const.call(1).should == @const.call(2)
  end
  
  it "should have arity 0" do
    @const.arity.should == 0
  end
end

describe "PositiveOne" do
  it "should not be effected by parameters on call" do
    PositiveOne.new.call(1).should == PositiveOne.new.call(2)
  end
  it "should have arity 0" do
    PositiveOne.new.arity.should == 0
  end
  it "should need no children" do
    PositiveOne.new.valid_kid_range.should == (0..0)
  end
end

describe Terminal do
  before :each do
    @term = NegativeFive.new
  end
  
  it "should have an array representation" do
    @term.to_a.length.should == 1
    @term.to_a.first.should == @term
  end

  it "should have string representation" do
    @term.to_s.should == "-5"
  end

  it "should have depth one" do
    @term.depth.should == 1
  end

  it "should have a size one" do
    @term.size.should == 1
  end
end