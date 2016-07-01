class CorrectUserIdAgain < ActiveRecord::Migration
  def change
		rename_column :musics, :users_id, :user_id
  end
end