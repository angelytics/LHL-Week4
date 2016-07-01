class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true
      t.belongs_to :track, index: true
      t.string :title
      t.string :content
      t.integer :score
    end 
  end
end
