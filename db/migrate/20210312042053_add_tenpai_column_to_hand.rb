class AddTenpaiColumnToHand < ActiveRecord::Migration[6.1]
  def up
  	add_column :hands, :tenpai, :boolean
  end

  def down
  	remove_column :hands, :tenpai, :boolean
  end
end
