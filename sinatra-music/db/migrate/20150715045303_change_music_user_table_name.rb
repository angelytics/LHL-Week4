class ChangeMusicUserTableName < ActiveRecord::Migration
  def change
		rename_table :musics_users, :likes
  end
end