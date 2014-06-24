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
      new_round(result['id'].to_i)
      return result['id'].to_i
    end

    def new_round(match_id) #round_moves table
      command = <<-SQL
        INSERT INTO round_moves(match_id)
        VALUES(#{match_id})
        RETURNING id;
      SQL

      result = @db_adapter.exec(command).first
      # binding.pry
      command = <<-SQL
        UPDATE match_history
        SET current_round = #{result['id'].to_i}
        WHERE match_history.id = #{match_id};
      SQL

      @db_adapter.exec(command)
      return result['id'].to_i
    end

    def send_move(p1_move, p2_move, match_id) #round_moves table NOT WORKING YET
      command = <<-SQL 
        UPDATE round_moves
        SET  p1_move = #{p1_move}, p2_move = #{p2_move}
        FROM match_history m
        WHERE m.current_round = round_moves.id AND round_moves.match_id = #{match_id}
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).first
    end

    def set_round_outcome(match_id, winner_id, p1_score, p2_score) #NOT WORKING YET round_moves table
      command = <<-SQL
        UPDATE round_moves
        SET  round_winner = #{winner_id}, p1_score = #{p1_score}, p2_score = #{p2_score}
        FROM match_history m
        WHERE m.current_round = round_moves.id AND round_moves.match_id = #{match_id}
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).first
    end

    def retrieve_current_round(match_id) #round_moves table
      command = <<-SQL
        SELECT round_moves.id, p1, p1_move, p2, p2_move, round_winner, p1_score, p2_score, round_moves.match_id
        FROM round_moves, match_history
        WHERE match_history.current_round = round_moves.id AND round_moves.match_id = #{match_id};
      SQL

      return @db_adapter.exec(command).first
    end

    def retrieve_all_rounds(match_id) #round_moves table
      command = <<-SQL
        SELECT round_moves.id, p1, p1_move, p2, p2_move, round_winner, p1_score, p2_score, round_moves.match_id
        FROM round_moves, match_history
        WHERE match_id = #{match_id};
      SQL

      return @db_adapter.exec(command).first
    end

    def retrieve_user_info(user_id) #users table
      command = <<-SQL
        SELECT *
        FROM users
        WHERE id = #{user_id};
      SQL

      return @db_adapter.exec(command).first
    end

    def set_match_winner(match_id, user_id) #match_history table
      command = <<-SQL
        UPDATE match_history
        SET  winner = user_id
        WHERE id = #{match_id}
        RETURNING *;
      SQL

      return @db_adapter.exec(command).first
    end

    def delete_tables
      command = <<-SQL
        DROP TABLE round_moves CASCADE;
        DROP TABLE match_history CASCADE;
        DROP TABLE users CASCADE;
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

        ALTER TABLE match_history
          ADD current_round integer REFERENCES round_moves(id);
      SQL

      @db_adapter.exec(command)
    end

  end

  def self.orm
    @__db_adapter_instance ||= ORM.new
  end

end