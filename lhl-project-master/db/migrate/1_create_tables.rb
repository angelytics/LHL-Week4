class CreateTables < ActiveRecord::Migration
    def change
        #users
        create_table :users do |t|
            t.string :firstname
            t.string :lastname
            t.string :gender
            t.string :username
            t.string :email
            t.string :password
            t.timestamps
        end
        #post
        create_table :posts do |t|
            t.string :title
            t.string :image
            t.string :file
            t.string :category
            t.string :content
            t.integer :likes
            t.timestamps
        end
        #comments
        create_table :comments do |t|
            t.string :content
            t.integer :likes
            t.timestamps
        end
    end

end