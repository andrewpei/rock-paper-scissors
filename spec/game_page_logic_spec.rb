require 'spec_helper'
require_relative '../lib/scripts/user_sign_in.rb'

describe 'UserSignIn' do

  before(:all) do
    RPS.orm.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'rps-db-test'))
    RPS.orm.create_tables
  end

  before(:each) do
    RPS.orm.delete_tables
    RPS.orm.create_tables
  end

  after(:all) do
    RPS.orm.delete_tables
  end

  context "when the password is correct" do
    xit "returns the user object" do
      andrew = RPS.orm.create_user("Andrew", "asdf1234")
      input = {user_name: "Andrew", password: "asdf1234"}
      result = RPS::UserSignIn.run(input)
      expect(result[:user].class).to eq(RPS::User)
      expect(result[:user].user_name).to eq("Andrew")
    end
  end

  context "when the password is incorrect" do
    xit "returns an error" do
      andrew = RPS.orm.create_user("Andrew", "asdf1234")
      input = {user_name: "Andrew", password: "asdf"}
      result = RPS::UserSignIn.run(input)
      expect(result[:error]).to eq("User's password doesn't match the password in the database")
      expect(result[:success?]).to eq(false)
    end
  end

  context "when the user is not found" do
    it "returns an error" do
      input = {user_name: "Bob", password: "asdf1234"}
      # binding.pry
      result = RPS::UserSignIn.run(input)
      expect(result[:error]).to eq("User doesn't exist by that username")
      expect(result[:success?]).to eq(false)
    end
  end

end
