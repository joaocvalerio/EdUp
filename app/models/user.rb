class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  has_many :courses_users, dependent: :destroy
  has_many :courses, through: :courses_users
  has_many :created_courses, foreign_key: "user_id", class_name: "Course"
  validates :first_name, :last_name, presence: true


  def full_name
    self.first_name.capitalize + " " + self.last_name
  end

  def publisher?
    publisher
  end

  def state(course)
    CoursesUser.where(user_id: self.id, course_id: course.id).first.state
  end

end


