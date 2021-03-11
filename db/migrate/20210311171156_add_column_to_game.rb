class AddColumnToGame < ActiveRecord::Migration[6.1]
  def up
  	add_column :games, :kyoku, :integer
  end
  def down
  	remove_column :games, :kyoku, :integer
  end
end
