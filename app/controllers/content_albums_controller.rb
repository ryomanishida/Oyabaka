class ContentAlbumsController < ApplicationController

  def new
    @content_album = ContentAlbum.new
    @contents = current_user.contents
  end

  def create
    @album = Album.new
    @album.album_name = params[:content_album][:album_name]
    @album.save

    arr = params[:content_album][:content_id]
    arr.each do |content_id|
      @content_album = ContentAlbum.new
      @content_album.content_id = content_id.to_i
      @content_album.album_id = @album.id
      @content_album.save
    end
    redirect_to albums_path
  end

  private
  def content_album_params
    params.require(:content_album).permit(:content_id)
  end

end
