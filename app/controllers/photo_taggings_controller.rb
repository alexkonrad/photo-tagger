class PhotoTaggingsController < ApplicationController
  before_filter :must_own_to_tag!(params[:photo_taggings][:photo_id])

  def create
    @photo_tagging = PhotoTagging.new(params[:photo_tagging])

    if @photo_tagging.save
      render json: @photo_tagging
    else
      render json: @photo_tagging.errors, status: 422
    end
  end

end
