class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.publisher?
        scope.where(user_id: user.id)
      else
        user.courses
      end
    end
  end

  def create?
    user.publisher?
  end

  def update?
    record.user_id == user.id
  end
end



