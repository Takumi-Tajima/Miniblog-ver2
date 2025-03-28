class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable, :confirmable

  has_many :posts, dependent: :destroy

  validates :name, format: { with: /\A[a-zA-Z0-9]+\z/ }, length: { maximum: 20 }
  validates :profile, length: { maximum: 200 }
  validates :blog_url, format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/ }
end
