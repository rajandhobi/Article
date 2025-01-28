class CommentPolicy < ApplicationPolicy
  def index?
    true # Everyone can view comments
  end

  def show?
    true # Everyone can view a specific comment
  end

  def create?
    user&.has_role?(:admin) # Only admin can add comments
  end

  def update?
    user&.has_role?(:admin) # Only admin can update comments
  end

  def destroy?
    user&.has_role?(:admin) # Only admin can delete comments
  end
end
