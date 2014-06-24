require 'pg'
require 'pry-byebug'

module RPS
  class ORM
    attr_reader :db_adapter

    def initialize
      @db_adapter = PG.connect(host: 'localhost', dbname: 'rps-db')
    end

    def create_user(user_name, password)
      command = <<-SQL
        INSERT INTO users(user_name, password, matches_won, matches_lost)
        VALUES('#{user_name}', '#{password}', 0, 0)
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).first
      return RPS::User.new(result['id'], result['user_name'], result['password'])
    end

    def create_game(p1, p2) #round_moves table and match_history table
      command = <<-SQL
        INSERT INTO match_history(p1, p2)
        VALUES(#{p1}, #{p2})
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).first
      # binding.pry
      return result['id'].to_i
    end

    def new_round(match_id) #round_moves table
      command = <<-SQL
        INSERT INTO round_moves(match_id)
        VALUES(#{match_id})
        RETURNING *;
      SQL

      @db_adapter.exec(command)
      return 
    end

    def send_move(player_id, match_id, round_id, move) #round_moves table
      # command = <<-SQL
      #   UPDATE round_moves
      #   SET 
      #   WHERE 
      #   RETURNING *;
      # SQL

      # result = @db_adapter.exec(command).first
    end

    def lookup_player(user_name)
    end

    def set_round_outcome(winner_id, p1_score, p2_score) #round_moves table
    end

    def retrieve_round_moves(game_id) #round_moves table
    end

    def retrieve_user_info(user_id) #users table
    end

    def retrieve_winners_match(user_id) #match_history table
    end

    def set_match_winner(match_id, user_id) #match_history table
    end

    def delete_tables
      command = <<-SQL
        DROP TABLE round_moves;
        DROP TABLE match_history;
        DROP TABLE users;
      SQL

      @db_adapter.exec(command)
    end

    def create_tables
      command = <<-SQL
        CREATE TABLE users(
          id serial PRIMARY KEY,
          user_name text,
          password text,
          matches_won integer,
          matches_lost integer
        );

        CREATE TABLE match_history(
          id serial PRIMARY KEY,
          winner integer REFERENCES users(id),
          p1 integer REFERENCES users(id),
          p2 integer REFERENCES users(id)
        );

        CREATE TABLE round_moves(
          id serial PRIMARY KEY,
          p1_move text,
          p2_move text,
          round_winner integer REFERENCES users(id),
          p1_score integer,
          p2_score integer,
          match_id integer REFERENCES match_history(id)
        );
      SQL

      @db_adapter.exec(command)
    end

  end

  def self.orm
    @__db_adapter_instance ||= ORM.new
  end

end