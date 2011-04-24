class CreateGoodBadVotes < ActiveRecord::Migration
  def self.up
    create_table :good_bad_votes do |t|
      t.integer :user_id
      t.integer :election_id
      t.integer :selection_id
      t.string :choice

      t.timestamps
    end
  end

  def self.down
    drop_table :good_bad_votes
  end
end
