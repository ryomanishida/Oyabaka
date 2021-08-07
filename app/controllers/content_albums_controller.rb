class ContentAlbumsController < ApplicationController

  def new
    @content_album = ContentAlbum.new
    @contents = current_user.contents
  end

  def create
    @album = Album.new#アルバム名
    @album.album_name = params[:content_album][:album_name]
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
    # 既存のデータを取得したい
    @album = Album.find(params[:id])
  end

  def update
    # 既存のデータ以外があればcontentalbumについか
  end


  private
  def content_album_params
    params.require(:content_album).permit(:content_id)
  end

end
