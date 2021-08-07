class Album < ApplicationRecord
  has_many :content_albums
  has_many :contents, through: :content_albums
end
