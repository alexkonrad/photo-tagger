# == Schema Information
#
# Table name: photo_taggings
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  photo_id   :integer          not null
#  x_pos      :integer          not null
#  y_pos      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PhotoTaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
