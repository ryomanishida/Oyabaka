class AlbumsController < ApplicationController

  def index
    @albums = current_user.albums
  end

  def show
    @album = Album.find(params[:id])
    @content_albums = @album.content_albums
    unless @album.user == current_user
      redirect_to albums_path
    end
  end


  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_path(@album)
    else
      @content_albums = @album.content_albums
      render :show
    end
  end

  def destroy
    album = Album.find(params[:id])
    if album.destroy
      redirect_to albums_path
    else
      render :index
    end
  end

  private
  def album_params
    params.require(:album).permit(:album_name, :user_id)
  end
end
