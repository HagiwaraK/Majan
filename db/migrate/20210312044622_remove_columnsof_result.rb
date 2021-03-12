class RemoveColumnsofResult < ActiveRecord::Migration[6.1]
  def up
  	remove_column :results, :first_winner_hand, :integer
  	remove_column :results, :second_winner_hand, :integer
  end

  def down
  	add_column :results, :first_winner_hand, :integer
  	add_column :results, :second_winner_hand, :integer
  end
end
