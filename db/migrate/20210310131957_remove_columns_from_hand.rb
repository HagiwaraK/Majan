class RemoveColumnsFromHand < ActiveRecord::Migration[6.1]
  def up
    remove_column :hands, :four_winds, :boolean
  end

  def down
    add_column :hands, :four_winds, :boolean
  end
end
