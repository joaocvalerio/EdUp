class Course < ApplicationRecord
  belongs_to :company
  belongs_to :publisher, class_name: "User", foreign_key: "user_id"
  has_many :courses_users, dependent: :destroy
  has_many :students, through: :courses_users, source: :user
  has_many :parts, dependent: :destroy
  validates :name, uniqueness: { scope: :company }
  validates :name, :description, presence: true
end

