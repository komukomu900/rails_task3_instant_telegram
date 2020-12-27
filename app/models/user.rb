class User < ApplicationRecord
  has_many :blogs
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 200 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }
end