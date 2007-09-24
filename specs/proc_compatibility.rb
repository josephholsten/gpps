require 'src/program'

describe "Program proc interface" do
  it "should accept [] as call" do
    program = Program.generate
    data = []
    for i in 0..program.arity
      data[i] = rand
    end
    
    program[data].should == program.call(data)
  end
  
  it "should have arity" do
    program  = Program.generate
    
    program.arity.should be_a_kind_of(Numeric)
  end
  
  it "should express equality" do
    program = Program.generate

    program.should == program
  end
  
  it "should repsond to call" do
    program = Program.generate
    data = []
    for i in 0..program.arity
      data[i] = rand
    end

    program.call(data).should be_a_kind_of(Numeric)
  end
end