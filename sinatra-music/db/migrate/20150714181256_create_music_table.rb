class CreateMusicTable < ActiveRecord::Migration
  def change
		create_table :musics do |t|
		t.string :title, null: false
		t.string :author, null: false
		t.string :url
		t.timestamp :created_at
		t.timestamp :updated_at
		end
  end
end