class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :public_id
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :age

      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
