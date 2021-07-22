class ContentCategory < ApplicationRecord
  belongs_to :content
  belongs_to :category
  validates :content_id,presence:true
  validates :category_id,presence:true
end
