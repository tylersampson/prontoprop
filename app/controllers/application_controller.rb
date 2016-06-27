class ApplicationController < ActionController::Base
  include Pundit
  before_action :save_index_state, only: :index
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  add_flash_types :success, :warning

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorizedi

  def index

  end

  protected
    def save_index_state
      key = "params_#{params[:controller]}"
      session[key] = {}
      session[key][:q] = params[:q]
      session[key][:page] = params[:page]
      session[key][:per] = params[:per]
      session[:default_per] = params[:per] unless params[:per].nil?
    end

  private
    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore
      redirect_to (request.referrer || root_path),
        error: I18n.t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)
    end
end
