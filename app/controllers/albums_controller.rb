class AlbumsController < ApplicationController

  def index
    @albums=Album.all
  end

  def show
    @album=Album.find(params[:id])
  end

  def add
    @contents=current_user.contents
  end

  def new
  end

  def create
  end

  def update
    @album=Album.find(params[:id])
    if @album.update(album_params)
      redirect_to content_path
    else
      render :show
    end
  end

  def destroy
    @album=Album.find(params[:id])
    if @album.destroy
      redirect_to albums_path
    else
      render :index
    end
  end

  private
  def album_params
    params.require(:album).permit(:album_name)
  end
end
