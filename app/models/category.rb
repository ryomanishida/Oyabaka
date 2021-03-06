class Category < ApplicationRecord
  validates :tag_name,presence:true,length:{maximum:50}
  has_many :content_categories, dependent: :destroy
  has_many :contents, through: :content_categories
end
