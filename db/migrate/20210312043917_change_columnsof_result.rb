class ChangeColumnsofResult < ActiveRecord::Migration[6.1]
  def up
  	rename_column :results, :first_winner, :first_winner_user_id
  	rename_column :results, :second_winner, :second_winner_user_id

  	remove_column :results, :first_leader_waiting, :boolean
  	remove_column :results, :second_leader_waiting, :boolean
  	remove_column :results, :third_leader_waiting, :boolean
  	remove_column :results, :fourth_leader_waiting, :boolean
  
   	add_column :results, :first_leader_hand_id, :integer
   	add_column :results, :second_leader_hand_id, :integer
   	add_column :results, :third_leader_hand_id, :integer
   	add_column :results, :fourth_leader_hand_id, :integer
  end

  def down
  	rename_column :results, :first_winner_user_id, :first_winner
  	rename_column :results, :second_winner_user_id, :second_winner
 
  	add_column :results, :first_leader_waiting, :boolean
  	add_column :results, :second_leader_waiting, :boolean
  	add_column :results, :third_leader_waiting, :boolean
  	add_column :results, :fourth_leader_waiting, :boolean
 
  	remove_column :results, :first_leader_hand_id, :integer
   	remove_column :results, :second_leader_hand_id, :integer
   	remove_column :results, :third_leader_hand_id, :integer
   	remove_column :results, :fourth_leader_hand_id, :integer
  end
end
