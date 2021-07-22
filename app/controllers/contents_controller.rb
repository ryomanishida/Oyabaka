class ContentsController < ApplicationController

  def index
    @contents=Content.all
  end

  def new
    @content=Content.new
  end

  def create
    @content=Content.new(content_params)
    @content.user_id=current_user.id
    #category_list = params[:category_list].split(",")
    if @content.save
      #@content.save_categories(category_list)
      flash[:success] = "投稿しました"
      redirect_to content_path(@content)
    else
      render :new
    end
  end

  def show
    @content=Content.find(params[:id])
    @comment=Comment.new
  end

  def edit
    @content=Content.find(params[:id])
  end

  def update
    @content=Content.find(params[:id])
    if @content.update(content_params)
      redirect_to content_path
    else
      render :edit
    end
  end

  def destroy
    @content=Content.find(params[:id])
    if  @content.destroy
      redirect_to contents_path
    else
      render :edit
    end
  end

  private

  def content_params
    params.require(:content).permit(:title, :introduction, :img, :user_id)
  end
end
