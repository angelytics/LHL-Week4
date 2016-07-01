class CorrectPassword < ActiveRecord::Migration
  def change
  rename_column :users, :passwordn, :password
	end
end