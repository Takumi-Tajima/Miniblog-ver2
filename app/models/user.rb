class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy, inverse_of: :followed
  has_many :following, through: :active_relationships, source: :followed

  validates :name, format: { with: /\A[a-zA-Z0-9]+\z/ }, length: { maximum: 20 }
  validates :biography, length: { maximum: 200 }

  def follow(user)
    return false if user.id == id

    following << user unless following?(user)
  end

  def unfollow(id)
    active_relationships.find_by(id: id)&.destroy
  end

  def following?(user)
    following.include?(user)
  end
end
