require 'rubygems'
require 'spec_helper.rb'

describe "Rock Paper Scissors game" do
  let(:game) {RPS::Game.new(1,2)}

  before(:all) do
    RPS.orm.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'rps-db-test'))
    RPS.orm.create_tables
  end

  before(:each) do
    RPS.orm.delete_tables
    RPS.orm.create_tables
    @andrew = RPS.orm.create_user('Andrew', 'asdf1234')
    @gabe = RPS.orm.create_user('Gabe', 'asdf1234')
    @game = RPS::Game.new(@andrew.user_id,@gabe.user_id)
  end

  after(:all) do
    RPS.orm.delete_tables
  end

  it "creates a new game" do
    expect(@game).to be_a(RPS::Game)
  end

  it "takes a player move when no other move has been made" do
    move_result = @game.player_move(@andrew.user_id, 'rock')
    expect(move_result).to eq('Next player turn')
  end

  it "plays a round when two player's have made moves and they draw" do
    @game.player_move(@andrew.user_id, 'rock')
    result = @game.player_move(@gabe.user_id, 'rock')
    expect(result[0]['round_winner'].to_i).to eq(0)
  end

  it "plays round where one player wins" do
    @game.player_move(@andrew.user_id, 'rock')
    result = @game.player_move(@gabe.user_id, 'scissors')
    expect(result[0]['round_winner'].to_i).to eq(@andrew.user_id)
  end

  xit "finishes the game" do
    @game.player_move(@andrew.user_id, 'rock')
    @game.player_move(@gabe.user_id, 'rock')

    @game.player_move(@andrew.user_id, 'rock')
    @game.player_move(@gabe.user_id, 'scissors')

    @game.player_move(@andrew.user_id, 'paper')
    @game.player_move(@gabe.user_id, 'scissors')

    @game.player_move(@andrew.user_id, 'paper')
    result1 = @game.player_move(@gabe.user_id, 'rock')
    # binding.pry
    @game.player_move(@andrew.user_id, 'scissors')
    result = @game.player_move(@gabe.user_id, 'paper')
    
  end

end
