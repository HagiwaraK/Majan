class AddColumnsToHand < ActiveRecord::Migration[6.1]
  def up
    add_column :hands, :pure_nine_gates, :boolean
    add_column :hands, :suttan, :boolean
    add_column :hands, :all_waitting_thirteen_orphans, :boolean
    add_column :hands, :blessing_of_person, :boolean
    add_column :hands, :big_four_winds, :boolean
    add_column :hands, :small_four_winds, :boolean
    add_column :hands, :three_continuous_triples, :boolean
    add_column :hands, :four_continuous_triples, :boolean
    add_column :hands, :pon, :integer
    add_column :hands, :chi, :integer
    add_column :hands, :ankan, :integer
    add_column :hands, :kakan, :integer
    add_column :hands, :minkan, :integer
  end

  def down
    remove_column :hands, :pure_nine_gates, :boolean
    remove_column :hands, :suttan, :boolean
    remove_column :hands, :all_waitting_thirteen_orphans, :boolean
    remove_column :hands, :blessing_of_person, :boolean
    remove_column :hands, :big_four_winds, :boolean
    remove_column :hands, :small_four_winds, :boolean
    remove_column :hands, :three_continuous_triples, :boolean
    remove_column :hands, :four_continuous_triples, :boolean
    remove_column :hands, :pon, :integer
    remove_column :hands, :chi, :integer
    remove_column :hands, :ankan, :integer
    remove_column :hands, :kakan, :integer
    remove_column :hands, :minkan, :integer
  end
end
