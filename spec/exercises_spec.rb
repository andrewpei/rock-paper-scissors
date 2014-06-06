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
  
  it "" do

  end
end

describe "Exercise 6" do
  
  it "updates the last element in the array to panda" do
    result = Exercises.ex6([1,2,3,4])
    expect(result).to eq('panda')
  end

  it "if the last element is panda it changes the last element to godzilla" do
    result = Exercises.ex6([1,2,3,'panda'])
    expect(result).to eq('GODZILLA')
  end

end

describe "Exercise 7" do
  
  it "expects that if the string exists in the array that it will be added to the end" do

  end

  it "expects if the string is not in the array that nothing happens" do

  end
end

describe "Exercise 8" do
  
  it "" do

  end

  it "" do

  end

end

describe "Exercise 9" do
  
  it "" do

  end

  it "" do

  end

end