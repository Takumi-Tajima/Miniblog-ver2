class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { maximum: 140 }

  scope :default_order, -> { order(:id) }

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
