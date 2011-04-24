class AddColumn01 < ActiveRecord::Migration
  def self.up
    add_column :elections, :show_key, :string
  end

  def self.down
  end
end
