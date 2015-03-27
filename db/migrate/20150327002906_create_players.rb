class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.string :type, null: false
      t.integer :age

      t.timestamps null: false
    end
  end
end
