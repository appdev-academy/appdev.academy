class ArticlesController < ApplicationController
  
  def index
    @articles = Article.where(is_hidden: false).where.not(published_at: nil).order('position DESC')
  end
  
  def show
    @article = Article.find_by!(slug: params[:slug])
  end
end