class CategoriesController < ApplicationController
  def show
    @category=Category.find(params[:id])
    @contents=@category.contents
  end
end
