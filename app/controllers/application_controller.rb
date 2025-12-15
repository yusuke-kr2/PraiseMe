class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :require_login

  private

  def require_login

    return if logged_in?

    redirect_to root_path, alert: "ニックネームで登録してください"
  end

  def logged_in?
    session[:user_id].present?
  end
end
