require 'spec_helper'

describe 'ORM' do
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

  it "is an ORM" do
    expect(RPS.orm).to be_a(RPS::ORM)
  end

  it "is created with a db adapter" do
    expect(RPS.orm.db_adapter).not_to be_nil
  end

  it "creates a new user properly" do
    user = RPS.orm.create_user("Andrew", "asdf1234")
    expect(user.name).to eq("Andrew")
    expect(user).to be_a(RPS::User)
  end

  it "creates a new game with two players properly" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    match_id = RPS.orm.create_game(1,2)
    expect(match_id).to eq(1)
  end

  it "creates an empty new round" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    user3 = RPS.orm.create_user("Gideon", "asdf1234")
    user4 = RPS.orm.create_user("Jon", "asdf1234")
    match_id1 = RPS.orm.create_game(1,2)
    match_id2 = RPS.orm.create_game(3,4)
    new_round1 = RPS.orm.new_round(match_id1)
    new_round2 = RPS.orm.new_round(match_id2)
    binding.pry
    expect(new_round).to eq(match_id1)
  end

end