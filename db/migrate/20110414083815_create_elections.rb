class CreateElections < ActiveRecord::Migration
  def self.up
    create_table :elections do |t|
      t.integer :user_id
      t.string :title
      t.string :mode
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :one_vote
      t.string :three_vote
      t.string :rank_vote
      t.string :free_choice_vote
      t.string :good_bad_vote

      t.timestamps
    end
  end

  def self.down
    drop_table :elections
  end
end
