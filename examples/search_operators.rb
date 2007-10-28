require 'src/function'
require 'src/terminal'
require 'src/program'

describe "Search Operations" do
  it "should implement crossover" do
    pending("reproduction")
  end

  it "should implement mutation" do
    non_zero_terminals = [NegativeFive,
                          NegativeFour,
                          NegativeThree,
                          NegativeTwo,
                          NegativeOne,
                          PositiveOne,
                          PositiveTwo,
                          PositiveThree,
                          PositiveFour,
                          PositiveFive]
    program = Plus.new [Zero.new, Zero.new]
    child = program.mutate(Functions, non_zero_terminals, nil)
    child.should_not == program
  end
  

  it "should implement terminal mutation" do
    non_zero_terminals = [NegativeFive,
                          NegativeFour,
                          NegativeThree,
                          NegativeTwo,
                          NegativeOne,
                          PositiveOne,
                          PositiveTwo,
                          PositiveThree,
                          PositiveFour,
                          PositiveFive]
    program = Zero.new
    child = program.mutate(Functions, non_zero_terminals, nil)
    child.should_not == program
  end
end

describe "Reproduction Operation" do
  it "should clone a program" do
    program = Zero.new
    prog_copy = program.clone
    program.should == prog_copy
    program.should_not equal?(prog_copy)
  end
  
  
  it "should clone a function program" do
    program = Plus.new [Zero.new, Zero.new]
    prog_copy = program.clone
    program.should == prog_copy
    program.should_not equal?(prog_copy)
  end
  
  it "should not affect clones when modified" do
    program = Plus.new [Zero.new, Zero.new]
    prog_copy = program.clone
    
    # verify original and clone equivalence
    program.should == prog_copy
    program.should_not equal?(prog_copy)

    # Modify the original, not the clone
    program.kids[0] = PositiveOne.new
    program.should_not == prog_copy
    program.should_not equal?(prog_copy)
  end
  
  it "should equate programs" do
    program1 = Plus.new [Zero.new, Zero.new]
    program2 = Plus.new [Zero.new, Zero.new]
    program1.should == program2
  end
  
  it "should equate terminals" do
    term1 = Zero.new
    term2 = Zero.new
    term1.should == term2
  end
end