class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  validate :user_not_voted_on_track
  after_create :update_track_upvotes

  def user_not_voted_on_track
    # finds duplicate
    if Vote.where("user_id = ? AND track_id = ?", self.user_id, self.track_id).first
      self.errors.add(:user_id, 'cannot upvote same song twice.')
    end
  end

  def update_track_upvotes
    self.track.update_upvotes if self.track
  end


end