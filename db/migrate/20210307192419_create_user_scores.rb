class CreateUserScores < ActiveRecord::Migration[6.1]
  def change
    create_table :user_scores do |t|
      t.integer :user_id
      t.integer :point
      t.integer :tip

      t.timestamps
    end
  end
end
