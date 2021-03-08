class AddColumnHalfRoundIdToUserScore < ActiveRecord::Migration[6.1]
  def up
  	add_column :user_scores, :half_round_id, :integer
  end
  def down
  	remove_column :user_scores, :half_round_id, :integer
  end
end
