require 'src/function'
require 'src/terminal'

describe "Search Operations" do
  it "should implement crossover" do
    pending("reproduction")
  end

  it "should implement mutation" do
    pending("reproduction")
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
  
  it "should randomly pick a program" do
    pending "reproduction"
    #As a test, generate a population
    population = Populate.new()
    #Randomly pick an element in the array, and store it in a temporary variable
    tempProgram = RandomPick(population)
    #tempProgram.should == 
    ########    Joe, maybe you can help me out right here.  I'm not sure exactly how to tell it it 'should' be
    ########    random.  I also am not sure of the difference between this:  return a random program and return
    ########    a random program.  Both should be the same thing, right?  I may be getting caught up in how simple
    ########    the reproduce operator will be.  I find it difficult to think of things it should be doing other 
    ########    than the obvious.  Also, I imagine that a population consists of an array of programs, which are
    ########    arrays of functions and terminals (which themselves are elements of arrays Functions, Terminsals).
    ########    Am I right about this?
    
  end
  
end