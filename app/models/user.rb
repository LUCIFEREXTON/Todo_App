class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true
  validates :name, presence: true, uniqueness: true
  has_many :lists, class_name: "list", foreign_key: "reference_id"
end
