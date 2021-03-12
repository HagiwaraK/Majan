class AddColumnsToHalfRound < ActiveRecord::Migration[6.1]
  def up
  	add_column :half_rounds, :first_leader_user_id, :integer
  	add_column :half_rounds, :second_leader_user_id, :integer
  	add_column :half_rounds, :third_leader_user_id, :integer
  	add_column :half_rounds, :fourth_leader_user_id, :integer
  end

  def down
  	remove_column :half_rounds, :first_leader_user_id, :integer
  	remove_column :half_rounds, :second_leader_user_id, :integer
  	remove_column :half_rounds, :third_leader_user_id, :integer
  	remove_column :half_rounds, :fourth_leader_user_id, :integer
  end
end
