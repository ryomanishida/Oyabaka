class ContentsController < ApplicationController
  def search
    @ranks = Content.find(Like.group(:content_id).order('count(content_id) desc').limit(3).pluck(:content_id))
    @tags = Category.all
    if params[:title].present?
      @contents = Content.where('title LIKE ?', "%#{params[:title]}%")
    else
      @contents = Content.all
    end
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    @content.user_id = current_user.id
    category_list = params[:content][:tag_names].gsub(/[[:blank:]]+/, ',').split(',')
    if @content.save
      @content.categories_save(category_list)
      redirect_to content_path(@content)
    else
      flash[:alert] = @content.errors.full_messages
      redirect_to new_content_path
    end
  end

  def show
    @content = Content.find(params[:id])
    @comment = Comment.new
    @content_tags = @content.categories
    @user = @content.user
    @albums = current_user.albums
  end

  def edit
    @content = Content.find(params[:id])
    unless @content.user == current_user
      redirect_to search_contents_path
    end
  end

  def update
    @content = Content.find(params[:id])
    category_list = params[:content][:tag_names].gsub(/[[:blank:]]+/, ',').split(',')
    if @content.update(content_params)
      @content.categories_save(category_list)
      redirect_to content_path(@content)
    else
      flash[:alert] = @content.errors.full_messages
      redirect_to edit_content_path(@content)
    end
  end

  def destroy
    @content = Content.find(params[:id])
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
