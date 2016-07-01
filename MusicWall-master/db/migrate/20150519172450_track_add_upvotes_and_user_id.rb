class TrackAddUpvotesAndUserId < ActiveRecord::Migration
  def change
    add_column :tracks, :upvotes, :integer
    add_column :tracks, :user_id, :integer
  end
end