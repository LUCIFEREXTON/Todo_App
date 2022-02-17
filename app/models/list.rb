class List < ApplicationRecord
  belongs_to :user
  has_many :todos, class_name: "todo", foreign_key: "reference_id"
end
