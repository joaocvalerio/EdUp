class Course < ApplicationRecord
  belongs_to :company
  has_many :courses_users, dependent: :destroy
  has_many :users, through: :courses_users
  has_many :parts, dependent: :destroy
  validates :name, uniqueness: { scope: :company }
  validates :name, :description, presence: true
end
