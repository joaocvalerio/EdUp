class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :courses, dependent: :destroy
  validates :name, uniqueness: true
end
