class ContentAlbumsController < ApplicationController

  def new
    @content_album = ContentAlbum.new
    @contents = current_user.contents
  end

  def create
    @album = Album.new#アルバム名
    @album.album_name = params[:content_album][:album_name]
    @album.user_id = current_user.id
    @album.save

    arr = params[:content_album][:content_id]
    arr.delete_at(0)#チェックボックスの１つ目の空を除去
    arr.each do |content_id|
      @content_album = ContentAlbum.new
      @content_album.content_id = content_id.to_i
      @content_album.album_id = @album.id
      @content_album.save
    end
    redirect_to albums_path
  end

  def edit
    @contents = current_user.contents
    @content_album = ContentAlbum.new
    @content_albums = ContentAlbum.find(params[:id])# 既存のデータを取得
  end

  def update
    @content_albums = ContentAlbum.find(params[:id])
    album = @content_albums.album
    arr = params[:content_album][:content_id]
    arr.delete_at(0)
    content_ids = album.content_albums.pluck(:content_id)
    album.content_albums.where(content_id: content_ids-arr).destroy_all#チェックを外した時データを削除
    arr.each do |content_id|
      if album.content_albums.where(content_id: content_id).blank?#新規チェックが入ったとき
        content_album = album.content_albums.new(content_id: content_id)
        content_album.save
      end
    end
    redirect_to albums_path
  end


  private
  def content_album_params
    params.require(:content_album).permit(:content_id)
  end

end
