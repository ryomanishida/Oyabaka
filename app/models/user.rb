class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contents, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def active_for_authentication?#退会ユーザーのログイン不可
    super && (self.is_active == true)
  end

  mount_uploader :profile_image, ProfileImageUploader

end
