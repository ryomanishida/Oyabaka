class ContentAlbum < ApplicationRecord
  belongs_to :content
  belongs_to :album
end
