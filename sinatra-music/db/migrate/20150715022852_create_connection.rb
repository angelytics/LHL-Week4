class CreateConnection < ActiveRecord::Migration
  def change
		add_reference :musics, :users, index: true
  end
end