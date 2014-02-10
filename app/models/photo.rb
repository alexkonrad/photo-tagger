# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  owner_id   :integer          not null
#  url        :string(255)      not null
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ActiveRecord::Base
  attr_accessible :owner_id, :url, :title

  validates :owner_id, :url, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id
  )

  has_many(
    :taggings,
    class_name: "PhotoTagging",
    foreign_key: :photo_id,
    primary_key: :id
  )

  has_many :tagged_users, through: :taggings, source: :tagged_user
end
