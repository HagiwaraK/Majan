class AddKyotakuColumnToGame < ActiveRecord::Migration[6.1]
  def up
   	add_column :games, :kyotaku, :integer
  end

  def down
   	remove_column :games, :kyotaku, :integer
  end
end
