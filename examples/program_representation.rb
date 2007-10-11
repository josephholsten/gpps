require 'src/program'

describe "Program representation" do
  it "should call recursively call programs" do
    child = Plus.new([PositiveOne.new, PositiveOne.new])
    parent = Plus.new([child, PositiveOne.new])
    parent.call.should == 3
  end
  
  it "should find the depth of a simple program" do
    program = Plus.new [Zero.new, Zero.new]
    program.depth.should == 2
  end
  
  it "should find the depth of a deep program" do
    first = Modulus.new [Zero.new, PositiveThree.new]
    second = Plus.new [first, Zero.new]
    third = Plus.new [second, Zero.new]
    third.depth.should == 4
  end
  
  it "should find the node size of a simple program" do
    program = Plus.new [Zero.new, Zero.new]
    program.size.should == 3
  end
  
  it "should find the node size of a deep program" do
    first = Modulus.new [Zero.new, PositiveThree.new]
    second = Plus.new [first, Zero.new]
    third = Plus.new [second, Zero.new]
    third.size.should == 7
  end
  
  it "should have string representation" do
    Plus.new([Zero.new, Zero.new]).to_s.should == "(Plus 0 0)"
  end
  
  it "should generate the string representation of a deep program" do
    first = Modulus.new [Zero.new, PositiveThree.new]
    second = Plus.new [first, Zero.new]
    third = Plus.new [second, Zero.new]
    third.to_s.should == "(Plus (Plus (Modulus 0 3) 0) 0)"
  end
  
  it "should generate a random program" do
    program = Program.generate
    program.call.should be_a_kind_of(Numeric)
    program.depth.should be_a_kind_of(Numeric)
    program.size.should be_a_kind_of(Numeric)
  end

  it "should generate a random program of depth <= 1" do
    for i in 0..100
      Program.generate(Functions, Terminals, 1).depth.should <= 1
    end
  end

  it "should generate a random program of depth 2" do
    for i in 0..100
      Program.generate(Functions, Terminals, 2).depth.should <= 2
    end
  end

  it "should generate a random program within small depth" do
    for i in 0..100
      Program.generate(Functions, Terminals, 5).depth.should <= 5
    end
  end
  
  it "should generate ten random programs" do
    programs = []
    for i in 0..10
      programs[i] = Program.generate
    end
    
    programs.each {|p|
      p.call.should be_a_kind_of(Numeric)
      p.depth.should be_a_kind_of(Numeric)
      p.size.should be_a_kind_of(Numeric)
      p.to_s.should be_a_kind_of(String)
    }
  end
end

describe "Fitness" do
  it "should compare fitness" do
    actual_program = Plus.new([Multiply.new([VariableZero.new, VariableZero.new]), PositiveOne.new])
    expected_program = lambda {|i| i ** 2 + 1}
    test_data = (-10..10)
    Program.fitness(expected_program, actual_program, test_data).should == 0
  end
  
  it "should compare fitness of random program" do
    program_fitnesses = []
    (0..2000).each {
      p = Program.generate(Functions, Terminals + Variables, 8)
      f = Program.fitness(lambda {|j| ((j ** 2)/2) + 1}, p)
      program_fitnesses.push :program => p,:fitness => f
    }
    program_fitnesses.sort! {|x,y|
      x[:fitness] <=> y[:fitness]
    }
    program_fitnesses[0][:fitness].should <= program_fitnesses[2000][:fitness]
  end
end
