 class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def destroy?
    can_moderate?(user, record)
  end
 end