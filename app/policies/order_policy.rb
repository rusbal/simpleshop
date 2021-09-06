class OrderPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  relation_scope do |relation|
    next relation if user.admin?
    relation.where(user: user)
  end

  def index?
    user.admin? || owner?
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
