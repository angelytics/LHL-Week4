class Track < ActiveRecord::Base
  has_many :votes
  has_many :reviews
  belongs_to :user

  validates :title, :author, presence: true

  after_initialize :init

  def init
    self.upvotes ||= 0
    self.rating ||= 0
  end

  def update_upvotes
    self.upvotes = self.votes.count
    self.save
  end

  def update_rating
    self.rating = self.reviews.average(:score).to_i
    self.save
  end
end