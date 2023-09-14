# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    redirect_to root_path, status: :not_found
  end

  def unprocessable_entity
    render :new, status: :unprocessable_entity
  end
end
