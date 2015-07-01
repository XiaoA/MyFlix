class Category < ApplicationController
  def index
    @category = Category.all
  end
end
