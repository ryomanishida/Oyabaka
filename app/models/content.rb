class Content < ApplicationRecord

  mount_uploader :img, ImgUploader

  belongs_to :user
  has_many :categories, through: :content_categories
  has_many :content_categories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

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
end
