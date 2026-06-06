class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  
  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  def already_liked?(tweet)
    likes.exists?(tweet_id: tweet.id)
  end
end