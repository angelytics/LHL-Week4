class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  validates :title, :content, :score, presence: true
  validate :user_not_reviewed_track

  after_create :update_track_rating
  after_destroy :update_track_rating

  def user_not_reviewed_track
    # finds duplicate
    if Review.where("user_id = ? AND track_id = ?", self.user_id, self.track_id).first
      self.errors.add(:user_id, 'cannot review same song twice.')
    end
  end

  def update_track_rating
    self.track.update_rating if self.track
  end
end