# frozen-string-literal: true

class DealershipPolicy
  attr_reader :user, :dealership

  def initialize(user, dealership)
    @user = user
    @dealership = dealership
  end

  def index?
    verify_user_role_admin
  end

  def create?
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

  def destroy?
    verify_user_role_admin
  end

  private

  def verify_user_role_admin
    user.present? && user.admin?
  end
end
