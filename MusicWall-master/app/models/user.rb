class User < ActiveRecord::Base
  has_many :votes
  has_many :tracks
  has_many :reviews

  validates :email, :user_name, :password, presence: true
end