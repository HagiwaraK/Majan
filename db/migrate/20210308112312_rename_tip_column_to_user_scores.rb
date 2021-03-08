class RenameTipColumnToUserScores < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_scores, :tip, :chip
  end
end
