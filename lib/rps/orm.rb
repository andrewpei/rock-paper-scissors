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
      return RPS::User.new(result['id'].to_i, result['user_name'], result['password'])
    end

    def create_game(p1, p2) #round_moves table and match_history table
      command = <<-SQL
        INSERT INTO match_history(p1, p2, winner)
        VALUES(#{p1}, #{p2}, 0)
        RETURNING *;
      SQL

      new_match = @db_adapter.exec(command).first

      new_round(new_match['id'].to_i)
      command = <<-SQL
        UPDATE round_moves
        SET p1_score = 0, p2_score = 0
        WHERE round_moves.match_id = #{new_match['id'].to_i};
      SQL
      @db_adapter.exec(command)

      return RPS::Game.new(new_match['id'].to_i, new_match['p1'].to_i, new_match['p2'].to_i)
    end

    def new_round(match_id) #round_moves table
      command = <<-SQL
        INSERT INTO round_moves(match_id)
        VALUES(#{match_id})
        RETURNING id;
      SQL

      result = @db_adapter.exec(command).first
      command = <<-SQL
        UPDATE match_history
        SET current_round = #{result['id'].to_i}
        WHERE match_history.id = #{match_id};
      SQL

      @db_adapter.exec(command)
      return result['id'].to_i
    end


    def send_move(current_player, player_move, match_id)
      command = <<-SQL 
        UPDATE round_moves
        SET  #{current_player} = '#{player_move}'
        FROM match_history m
        WHERE m.current_round = round_moves.id AND round_moves.match_id = #{match_id}
        RETURNING *;
      SQL

      return @db_adapter.exec(command).first
    end

    def set_round_outcome(match_id, winner_id, p1_score, p2_score)
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
        WHERE match_history.id = #{match_id} AND round_moves.match_id = #{match_id}
        ORDER BY round_moves.id DESC;
      SQL

      result = @db_adapter.exec(command)
      output = []
      result.each { |row|
        output << row
      }
      # binding.pry
      return output
    end

    def retrieve_user_info(user_name) #users table
      command = <<-SQL
        SELECT *
        FROM users
        WHERE user_name = '#{user_name}';
      SQL
      result = @db_adapter.exec(command).first
      if result != nil
        return RPS::User.new(result['id'], result['user_name'], result['password'])
      end
    end

    def update_user_info(user_id, user_name, password)
      command = <<-SQL
        UPDATE users
        SET  user_name = '#{user_name}', password = '#{password}'
        WHERE id = #{user_id}
        RETURNING *;
      SQL

      return @db_adapter.exec(command).first
    end

    def update_user_wl(user_id, winner_id)
      player = retrieve_user_info(user_id)
      # binding.pry
      if user_id == winner_id
        player['matches_won'] = player['matches_won'].to_i + 1
        command = <<-SQL
          UPDATE users
          SET  matches_won = #{player['matches_won']}
          RETURNING *;
        SQL
      else
        player['matches_lost'] = player['matches_lost'].to_i + 1
        command = <<-SQL
          UPDATE users
          SET matches_lost = #{player['matches_lost']}
          RETURNING *;
        SQL
      end

      result = @db_adapter.exec(command).first
      # binding.pry
      return result
    end

    # def check_existing_game(p1_id, p2_id)
    #   command = <<-SQL
    #     SELECT winner
    #     FROM match_history
    #     WHERE (p1 = #{p1_id} AND p2 = #{p2_id}) OR (p1 = #{p2_id} AND p2 = #{p1_id});
    #   SQL

    #   # can't use the first method here
    #   return @db_adapter.exec(command)
    # end

    def retrieve_other_users(user_id)
      command = <<-SQL
        SELECT *
        FROM users, match_history
        WHERE users.id NOT IN (user_id, );
      SQL
      users = []
      @db_adapter.exec(command).each { |row|
        users << RPS::User.new(row['id'].to_i, row['user_name'], row['password'], row['matches_won'].to_i, row['matches_lost'].to_i)
      }
      return users
    end

    def retrieve_user_match_history(user_id)
      command = <<-SQL
        SELECT id, winner, p1, p2
        FROM match_history
        WHERE p1 = #{user_id} OR p2 = #{user_id};
      SQL

      # can't use the first method here
      return @db_adapter.exec(command)
    end

    def set_match_winner(match_id, user_id) #match_history table
      command = <<-SQL
        UPDATE match_history
        SET  winner = #{user_id}
        WHERE id = #{match_id}
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).first

      update_user_wl(result['p1'].to_i, result['winner'].to_i)
      update_user_wl(result['p2'].to_i, result['winner'].to_i)

      return result
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
          winner integer,
          p1 integer REFERENCES users(id),
          p2 integer REFERENCES users(id)
        );

        CREATE TABLE round_moves(
          id serial PRIMARY KEY,
          p1_move text,
          p2_move text,
          round_winner integer,
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
