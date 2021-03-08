class RemoveLeadersScoresColumnsFromGames < ActiveRecord::Migration[6.1]
  def up
  	remove_column :games, :first_leader_score, :integer
  	remove_column :games, :second_leader_score, :integer
  	remove_column :games, :third_leader_score, :integer
  	remove_column :games, :fourth_leader_score, :integer
  end

  def down
  	add_column :games, :first_leader_score, :integer
  	add_column :games, :second_leader_score, :integer
  	add_column :games, :third_leader_score, :integer
  	add_column :games, :fourth_leader_score, :integer
  end
end
