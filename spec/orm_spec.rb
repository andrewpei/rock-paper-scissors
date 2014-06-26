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
    expect(new_round1).to eq(3)
  end

  it "sends a user's move to the db" do 
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    user3 = RPS.orm.create_user("Jon", "asdf1234")
    match_id1 = RPS.orm.create_game(1,2)
    match_id2 = RPS.orm.create_game(2,1)
    match_id2 = RPS.orm.create_game(2,1)
    match_id3 = RPS.orm.create_game(2,3)
    binding.pry
    current_player = 'p1_move'
    result = RPS.orm.send_move(current_player, 'rock', match_id1)
    binding.pry
    expect(result['p1_move']).to eq('rock')
  end

  it "sets the round outcome correctly" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    match_id1 = RPS.orm.create_game(1,2)
    outcome = RPS.orm.set_round_outcome(match_id1, user1.user_id, 1, 0)
    expect(outcome['round_winner']).to eq(user1.user_id)
  end

  it "retrieves the current round's info" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    match_id1 = RPS.orm.create_game(1,2)
    RPS.orm.new_round(match_id1)

    outcome = RPS.orm.retrieve_current_round(match_id1)
    # binding.pry
    expect(outcome['id'].to_i).to eq(2)
  end

  it "retrieve's all rounds for a match" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    user3 = RPS.orm.create_user("Jon", "asdf1234")
    match_id1 = RPS.orm.create_game(1,2)
    match_id3 = RPS.orm.create_game(2,3)
    RPS.orm.new_round(match_id1)
    RPS.orm.new_round(match_id1)

    outcome = RPS.orm.retrieve_all_rounds(match_id1)
    expect(outcome.size).to eq(3)
  end

  it "sets the winner of the match" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    match_id1 = RPS.orm.create_game(1,2)
    result = RPS.orm.set_match_winner(match_id1, user1.user_id)
    expect(result['winner']).to eq(user1.user_id)
  end

  it "retrieve's a user's info" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    result = RPS.orm.retrieve_user_info(user1.user_id)
    expect(result['user_name']).to eq("Andrew")
  end

  it "updates a user's user_name and password" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    expect(user1.name).to eq('Andrew')
    result = RPS.orm.update_user_info(user1.user_id, "Gabe", "blag1234")
    expect(result['user_name']).to eq('Gabe')
  end

  it "updates the user win loss record when a game is over" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    expect(user1.matches_won).to eq(0)
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    match_id1 = RPS.orm.create_game(1,2)
    RPS.orm.set_match_winner(match_id1, user1.user_id)
    result = RPS.orm.retrieve_user_info(user1.user_id)
    expect(result['matches_won'].to_i).to eq(1)
  end

end