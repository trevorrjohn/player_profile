class AddTeamAndPhotoToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :team, :string
    add_column :players, :photo_url, :string
  end end
