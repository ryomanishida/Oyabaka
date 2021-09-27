class Album < ApplicationRecord
  has_many :content_albums
  has_many :contents, through: :content_albums
  belongs_to :user
  validates :album_name, presence: true, length: { maximum: 15 }
  MAX_ALBUMS_COUNT = 6
  validate :albums_limit

  private
  def albums_limit
    errors.add(:base, "You can create up to #{MAX_ALBUMS_COUNT} albums") if user.albums.count >= MAX_ALBUMS_COUNT
  end
end
