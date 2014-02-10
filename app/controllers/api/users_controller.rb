class Api::UsersController < ApplicationController
  def photos

    @user = User.find(params[:id])

    if @user

      render json: @user.owned_photos
    else
      render json: @user.errors, status: 422
    end
  end
end