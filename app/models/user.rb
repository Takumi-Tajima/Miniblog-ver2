class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable, :confirmable

  has_many :posts, dependent: :destroy

  validates :name, format: { with: /\A[a-zA-Z0-9]+\z/ }, length: { maximum: 20 }
  validates :biography, length: { maximum: 200 }
end
