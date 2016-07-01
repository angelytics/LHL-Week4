class AddForeignKeys < ActiveRecord::Migration
    def change
        change_table :posts do |t|
            t.references :user
        end
        change_table :comments do |t|
            t.references :post
            t.references :user
        end
    end
end