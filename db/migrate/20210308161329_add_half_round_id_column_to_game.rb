class AddHalfRoundIdColumnToGame < ActiveRecord::Migration[6.1]
  def up
  	add_column :games, :half_round_id, :integer
  end

  def down
  	remove_column :games, :half_round_id, :integer
  end
end
