class UsersController < ApplicationController
  before_filter :require_login!, except: [:new, :create]

  def new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def photos
    @user = User.find(params[:id]).includes(:owned_photos)

    if @user
      render json: @user.owned_photos
    else
      render json: @user.errors, status: 422
    end
  end

  def destroy
    User.destroy(params[:id])

    redirect_to new_user_url
  end
end
