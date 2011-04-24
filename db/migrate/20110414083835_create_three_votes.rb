class CreateThreeVotes < ActiveRecord::Migration
  def self.up
    create_table :three_votes do |t|
      t.integer :user_id
      t.integer :election_id
      t.integer :selection_id

      t.timestamps
    end
  end

  def self.down
    drop_table :three_votes
  end
end
