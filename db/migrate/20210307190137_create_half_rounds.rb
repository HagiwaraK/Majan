class CreateHalfRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :half_rounds do |t|

      t.timestamps
    end
  end
end
