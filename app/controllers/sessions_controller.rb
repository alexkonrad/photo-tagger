class SessionsController < ApplicationController
  before_filter :require_login!, only: :destroy
  before_filter :require_no_current_user!, except: :destroy

  def new

  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login_user!(@user)

      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    logout_user!

    redirect_to new_session_url
  end
end
