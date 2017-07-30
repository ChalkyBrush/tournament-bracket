class InitialMigration < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.integer :game_id
      t.integer :competitor_count
      t.integer :competitors_per_heat
      t.integer :winners_per_heat
      t.integer :current_round, :default => 1
      t.timestamps
    end

    create_table :heats do |t|
      t.integer :competition_id
      t.integer :index
      t.integer :winner_count
      t.integer :player_count
      t.integer :round_number

      t.timestamps
    end

    create_table :players do |t|
      t.integer :heat_id
      t.integer :user_id
      t.integer :score
      t.string :gamertag

      t.integer :competition_id
      t.integer :is_winner, :default => 0

      t.timestamps
    end
  end
end

