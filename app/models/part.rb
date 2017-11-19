class Part < ApplicationRecord
  belongs_to :course
  validates :video, :description, presence: true
end
