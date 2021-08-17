class Album < ApplicationRecord
  has_many :content_albums
  has_many :contents, through: :content_albums
  belongs_to :user
  validates :album_name, presence: true, length: { maximum: 15 }
end
