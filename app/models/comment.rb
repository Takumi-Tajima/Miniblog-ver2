class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :default_order, -> { order(:created_at) }
end
