module ApplicationHelper

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def current_user=(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def login_user!(user)
    self.current_user = user
  end

  def logout_user!
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def require_login!
    redirect_to new_session_url unless logged_in?
  end

  def require_no_current_user!
    redirect_to root_url unless !current_user
  end

  def logged_in?
    !!current_user
  end
end
