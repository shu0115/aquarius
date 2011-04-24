class CreateRankVotes < ActiveRecord::Migration
  def self.up
    create_table :rank_votes do |t|
      t.integer :user_id
      t.integer :election_id
      t.integer :selection_id
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :rank_votes
  end
end
