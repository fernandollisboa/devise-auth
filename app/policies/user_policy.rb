# frozen-string-literal: true

class UserPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def index?
    verify_user_role_admin
  end

  def show?
    verify_user_role_admin
  end

  def edit?
    verify_user_role_admin
  end

  def update?
    verify_user_role_admin
  end

  private

  def verify_user_role_admin
    user.present? && user.admin?
  end
end
