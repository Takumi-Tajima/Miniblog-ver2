class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User', inverse_of: :active_relationships
  belongs_to :followed, class_name: 'User', inverse_of: :passive_relationships

  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :not_self_follow

  private

  def not_self_follow
    errors.add(:base, '自分自身はフォローできません') if follower_id == followed_id
  end
end
