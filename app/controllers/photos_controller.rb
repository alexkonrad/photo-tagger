class PhotosController < ApplicationController

  def create
    @photo = Photo.new(params[:photo])

    if @photo.save
      render json: @photo
    else
      render json: @photo.errors, status: 422
    end
  end

  def photo_taggings
    @photo = Photo.find(params[:id]).includes(:taggings)

    if @photo
      render json: @photo.taggings
    else
      render json: @photo.errors, status: 422
    end
  end

end
