class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true
  validates :name, presence: true, uniqueness: true
  has_many :users, class_name: "user", foreign_key: "reference_id"
end
