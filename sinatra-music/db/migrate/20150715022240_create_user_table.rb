class CreateUserTable < ActiveRecord::Migration
  def change
		create_table :users do |t|
		t.string :username, null: false
		t.string :passwordn, null: false
		t.string :email
		t.string :full_name
		end

  end
end