class ProductPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def delete?
    user.admin?
  end
end
