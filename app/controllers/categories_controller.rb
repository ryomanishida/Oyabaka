class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @contents = @category.contents
  end

  def destroy
    category = Category.find(params[:id])
    if  category.destroy
      redirect_to search_contents_path
    else
      render :edit
    end
  end
end
