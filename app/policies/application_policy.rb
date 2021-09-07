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
    user.id == record.send(record.is_a?(User) ? :id : :user_id)
  end
end
