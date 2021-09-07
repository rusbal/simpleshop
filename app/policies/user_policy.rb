class UserPolicy < ApplicationPolicy
  relation_scope do |relation|
    next relation if user.admin?
    relation.where(user: user)
  end

  def show?
    user.admin? || owner?
  end

  def create?
    true
  end

  def update?
    user.admin? || owner?
  end

  def delete?
    user.admin? || owner?
  end

  def destroy?
    user.admin? || owner?
  end
end
