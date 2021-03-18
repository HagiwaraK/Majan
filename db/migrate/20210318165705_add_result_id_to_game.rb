class AddResultIdToGame < ActiveRecord::Migration[6.1]
  def up
   	add_column :games, :result_id, :integer
  end

  def down
   	remove_column :games, :result_id, :integer
  end
end
