class PartPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    true
  end

  def create?
    is_user_owner?
  end

  def update?
    is_user_owner?
  end

  def destroy?
    is_user_owner?
  end

  private

  def is_user_owner?
    Course.find(record.course_id).publisher == user
  end
end
