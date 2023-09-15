# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def not_found
    redirect_to root_path, status: :not_found
  end

  def unprocessable_entity
    render :new, status: :unprocessable_entity
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end
end
