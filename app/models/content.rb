class Content < ApplicationRecord

  mount_uploader :img, ImgUploader

  belongs_to :user
  has_many :content_categories, dependent: :destroy
  has_many :categories, through: :content_categories
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :content_albums, dependent: :destroy
  has_many :albums, through: :content_albums
  validates :img, presence: true
  validates :title, presence: true, length: { maximum: 70 }
  validates :introduction, length: { maximum: 140 }


  def liked_by?(user)
    likes.where(user_id:user.id).exists?#引数で渡されたuser_idがlikesテーブル内に存在していればtrue
  end


  def categories_save(tags)
    current_tags = self.categories.pluck(:tag_name) #既存のタグ
    old_tags = current_tags - tags #古いタグ　
    new_tags = tags - current_tags #新しいタグ

    old_tags.each do |old_name| #古いタグ削除
      self.categories.delete Category.find_by(tag_name:old_name)
    end

    new_tags.each do |new_name| #新しいタグが未登録なら新規登録
      content_category = Category.find_or_create_by(tag_name:new_name)
      self.categories << content_category
    end
  end
  
  
  
  # scope :search, -> (search_params) do  #scopeでsearchメソッドを定義。(search_params)は引数
  #   return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

  #   title_like(search_params[:title])  #titleのあいまい検索
  # end
  
  # scope :title, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  # #scope :メソッド名 -> (引数) { SQL文 }
  # #if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
 
 
end