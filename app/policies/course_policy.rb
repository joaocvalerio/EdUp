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
    is_user_owner?
  end

 private

  def is_user_owner?
    record.user_id == user.id
  end
end



