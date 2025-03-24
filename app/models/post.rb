class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  scope :default_order, -> { order(:id) }
end
