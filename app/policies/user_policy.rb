class UserPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end