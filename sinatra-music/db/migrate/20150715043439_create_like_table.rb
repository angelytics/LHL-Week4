class CreateLikeTable < ActiveRecord::Migration
  def change
		create_join_table :users, :musics do |t|
		end
  end
end