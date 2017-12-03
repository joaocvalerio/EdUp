class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:index, :company_users], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(authenticated_root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
