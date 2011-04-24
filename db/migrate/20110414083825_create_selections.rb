class CreateSelections < ActiveRecord::Migration
  def self.up
    create_table :selections do |t|
      t.integer :user_id
      t.integer :election_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :selections
  end
end
