require 'spec_helper'
# require_relative '../lib/scripts/game_page_logic.rb'

describe "RPS::RetrieveMatchData" do

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

  it "should retreive the match's data" do
    user1 = RPS.orm.create_user("Andrew", "asdf1234")
    user2 = RPS.orm.create_user("Gabe", "asdf1234")
    match_id = RPS.orm.create_game(1,2).match_id
    RPS.orm.new_round(match_id)
    RPS.orm.new_round(match_id)
    input = {match_id: match_id}
    # binding.pry
    result = RPS::RetrieveMatchData.run(input)
    player1_id = result[:rounds][0]["p1"].to_i
    player2_id = result[:rounds][0]["p2"].to_i
    player1_name = result[:p1_name]["user_name"]
    player2_name = result[:p2_name]["user_name"]

    expect(player1_id).to eq(1)
    expect(player2_id).to eq(2)
    expect(player1_name).to eq("Andrew")
    expect(player2_name).to eq("Gabe")
  end

end
