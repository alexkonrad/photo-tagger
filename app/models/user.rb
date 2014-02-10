# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :username, :password, :session_token
  attr_reader :password

  after_initialize :ensure_session_token

  validates :username, :password_digest, :session_token, presence: true
  validates :session_token, :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :owned_photos,
    class_name: "Photo",
    foreign_key: :owner_id,
    primary_key: :id
  )

  has_many(
    :photo_taggings,
    class_name: "PhotoTagging",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many :tagged_photos, through: :photo_taggings, source: :photo

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def is_password?(guess)
    BCrypt::Password.new(self.password_digest).is_password?(guess)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.reset_session_token!
  end
end
