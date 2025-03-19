class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable

  validates :name, format: { with: /\A[a-zA-Z0-9]+\z/ }, length: { maximum: 20 }
end
