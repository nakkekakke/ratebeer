class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: "You should be signed in" if current_user.nil?
  end

  def ensure_admin_status
    redirect_to request.referrer, notice: "You don't have admin access!" if !current_user.admin?
  end

  def ensure_account_not_closed
    redirect_to signin_path, notice: "Your account is closed. Contact the admins for more information." if current_user.closed?
  end
end
