class RegionPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  relation_scope do |relation|
    next relation if user.admin?
    relation.where(user: user)
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def delete?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
