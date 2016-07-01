class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :track, index: true
    end 
  end
end