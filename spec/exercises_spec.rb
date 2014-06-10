require 'rubygems'
require_relative '../exercises.rb'

describe 'Exercise 0' do
  it "triples the length of a string" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe "Exercise 1" do
  
  it "Returns the number of elements in the array" do
    result = Exercises.ex1([1,2,3,4])
    expect(result).to eq(4)
  end

  it "Returns 0 is the array is empty" do
    result = Exercises.ex1([])
    expect(result).to eq(0)
  end

end

describe "Exercise 2" do
  
  it "return the second element in the array" do
    result = Exercises.ex2([1,2,3,4])
    expect(result).to eq(2)
  end

end

describe "Exercise 3" do
  
  it "returns the sum of an array of numbers" do
    result = Exercises.ex3([1,2,3,4])
    expect(result).to eq(10)
  end

end

describe "Exercise 4" do
  
  it "returns the max number in the array" do
    result = Exercises.ex4([1,2,3,4])
    expect(result).to eq(4)
  end

end

describe "Exercise 5" do
  
  it "prints out each element" do

  end
end

describe "Exercise 6" do
  
  it "updates the last element in the array to panda" do
    arr = [1,2,3,4]
    Exercises.ex6(arr)
    expect(arr[-1]).to eq('panda')
  end

  it "if the last element is panda it changes the last element to godzilla" do
    arr = [1,2,3,'panda']
    Exercises.ex6(arr)
    expect(arr[-1]).to eq('GODZILLA')
  end

end

describe "Exercise 7" do
  
  it "expects that if the string exists in the array that it will be added to the end" do
    arr = ["a","b","c"]
    Exercises.ex7(arr, "a")
    expect(arr[-1]).to eq('a')
  end

  it "expects if the string is not in the array that nothing happens" do
    arr = ["a","b","c"]
    Exercises.ex7(arr, "z")
    expect(arr[-1]).to eq('c')
  end
end

describe "Exercise 8" do
  it "" do

  end
end

describe "Exercise 9" do
  
  it "doesn't think it's a leap year if the year is divisible by 100 but not 400" do
    year = Time.new(2100)
    result = Exercises.ex9(year)
    expect(result).to eq(false)
  end

  it "is a leap year if the year is divisible by 400" do
    year = Time.new(2000)
    result = Exercises.ex9(year)
    expect(result).to eq(true)
  end

  it "is a leap year for a year divisible by 4" do
    year = Time.new(2004)
    result = Exercises.ex9(year)
    expect(result).to eq(true)
  end

  it "doesn't think its a leap year on a normal year" do
    year = Time.new(1997)
    result = Exercises.ex9(year)
    expect(result).to eq(false)
  end

end

describe "Rock Paper Scissors game" do

  it "Picks the right winner of the round when a the user input moves" do
    game = RPS.new("Andrew","Shehzan")
    result = game.pick_winner("rock", "scissors")
    expect(result).to eq("Andrew")
  end

  it "increments the score correctly when a winner is chosen" do
    game = RPS.new("Andrew","Shehzan")
    result = game.pick_winner("rock", "scissors")
    expect(game.player1score).to eq(1)
  end

  it "ends the game with the right winner when the game should be over" do
    game = RPS.new("Andrew","Shehzan")
    game.pick_winner("rock","rock")
    game.pick_winner("rock","paper")
    game.pick_winner("rock","scissors")
    game.pick_winner("paper","rock")
    result = game.check_if_over

    expect(result).to eq("Andrew")

  end

end