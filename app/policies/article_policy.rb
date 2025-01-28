class ArticlePolicy < ApplicationPolicy
  def create?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def update?
    user&.has_role?(:admin) || user == record.user # Admins or authors can update
  end

  def show?
    true # Anyone can view articles
  end
  
  def destroy?
    user&.has_role?(:admin) || user == record.user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user&.has_role?(:admin)
        scope.all
      else
        scope.none # Default to no articles for unauthenticated users
      end
    end
  end
end
