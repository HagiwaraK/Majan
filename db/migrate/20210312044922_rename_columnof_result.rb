class RenameColumnofResult < ActiveRecord::Migration[6.1]
  def up
  	rename_column :results, :loser, :loser_user_id
  end

  def down
  	rename_column :results, :loser_user_id, :loser
  end
end
