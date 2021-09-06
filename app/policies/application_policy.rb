# frozen_string_literal: true

class ApplicationPolicy < ActionPolicy::Base
  def index?
    true
  end

  def show?
    true
  end

  private

  def owner?
    user.id == record.user_id
  end
end
