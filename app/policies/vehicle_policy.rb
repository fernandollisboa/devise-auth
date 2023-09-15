# frozen-string-literal: true

class VehiclePolicy
  attr_reader :user, :vehicle

  def initialize(user, vehicle)
    @user = user
    @vehicle = vehicle
  end

  def new?
    verify_user_role_dealership
  end

  def index?
    true
  end

  def show?
    verify_user_role_dealership
  end

  def create?
    verify_user_role_dealership
  end

  def edit?
    verify_user_role_dealership
  end

  def update?
    verify_user_role_dealership
  end

  def destroy?
    verify_user_role_dealership
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present? && user.dealership?
        scope.where(dealership_id: user.dealership_id)
      else
        scope.all
      end
    end

    private

    attr_reader :user, :scope
  end

  private

  def verify_user_role_dealership
    user.present? && user.dealership?
  end
end
