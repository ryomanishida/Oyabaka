class Content < ApplicationRecord

  mount_uploader :img, ImgUploader

  belongs_to :user
  has_many :content_categories, dependent: :destroy#中間クラスとのアソシエーションを先に書く！
  has_many :categories, through: :content_categories
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :content_albums, dependent: :destroy
  has_many :albums, through: :content_albums
  validates :img, presence: true
  validates :title, presence: true, length: { maximum: 70 }
  validates :introduction, presence: true, length: { maximum: 120 }



  def liked_by?(user)
    likes.where(user_id:user.id).exists?#引数で渡されたuser_idがlikesテーブル内に存在していればtrue
  end

  def save_categories(tags)
    current_tags = self.categories.pluck(:tag_name) unless self.categories.nil? #現在の記事に登録されているタグの取得
    old_tags = current_tags - tags #古いタグの取得
    new_tags = tags - current_tags #新しいタグの取得

    old_tags.each do |old_name| #古いタグの削除
      self.categories.delete Category.find_by(tag_name:old_name)
    end

    new_tags.each do |new_name| #新しいタグが登録されていなければ新規登録
      content_category = Category.find_or_create_by(tag_name:new_name)
      self.categories << content_category
    end
  end

  def categories_save(category_list)
    if self.categories != nil
      content_categories_records = ContentCategory.where(content_id: self.id)
      content_categories_records.destroy_all
    end

    category_list.each do |category|
      inspected_category = Category.where(tag_name: category).first_or_create
      self.categories << inspected_category
    end
  end
end
