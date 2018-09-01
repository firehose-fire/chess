class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.name :string

      t.timestamps
    end
  end
end
