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

class PhotoTagging < ActiveRecord::Base
  attr_accessible :user_id, :photo_id, :x_pos, :y_pos

  validates :user_id, :photo_id, :x_pos, :y_pos, presence: true
  validates :user_id, uniqueness: { scope: :photo_id }

  belongs_to(
    :photo,
    class_name: "Photo",
    foreign_key: :photo_id,
    primary_key: :id
  )

  belongs_to(
    :tagged_user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
end
