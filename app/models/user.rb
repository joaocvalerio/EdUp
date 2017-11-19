class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  has_many :courses_users, dependent: :destroy
  has_many :courses, through: :courses_users
  validates :first_name, :last_name, presence: true
end
