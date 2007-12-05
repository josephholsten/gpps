require 'src/variable'

describe "Variable" do
  before :each do
    @var = VariableZero.new
  end
  
  it "should return variable on call" do
    @var.call(10, 20, 30).should == 10
  end

  it "should have a string representations for a variable" do
    @var.to_s.should == "x0"
  end
  
  it "should return second item" do
    VariableOne.new.call(10, 20, 30).should == 20
  end
end