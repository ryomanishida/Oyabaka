class ContentsController < ApplicationController

  def search
    @ranks = Content.find(Like.group(:content_id).order('count(content_id) desc').limit(3).pluck(:content_id))
    @tags = Category.all
    if params[:title].present?
      @contents = Content.where('title LIKE ?', "%#{params[:title]}%")
      # @search_params = content_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
      # @contents = Content.search(@search_params).joins(:user)  #searchメソッドを呼び出し、引数としてparamsを渡している
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
    tags = params[:content][:tag_names].gsub(/[[:blank:]]+/, ',').split(',')
    if @content.save
      @content.categories_save(tags)
      redirect_to content_path(@content)
    else
      flash[:alert] = @content.errors.full_messages
      redirect_to new_content_path
    end
  end

  def show
    @content = Content.find(params[:id])
    @comment = Comment.new
    @user = @content.user
    @albums = current_user.albums
  end

  def edit
    @content = Content.find(params[:id])
    @tags = Category.where(id: @content)
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
    content = Content.find(params[:id])
    if content.destroy
      redirect_to search_contents_path
    else
      @content = Content.find(params[:id])
      render :edit
    end
  end

  private

  def content_params
    params.require(:content).permit(:title, :introduction, :img, :user_id)
  end

  # def content_search_params
  #   params.fetch(:search, {}).permit(:title)
  #   #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
  #   #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  # end

end