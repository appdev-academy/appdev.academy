class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.where(is_hidden: false).where.not(published_at: nil).order('position DESC')
  end
  
  # GET /articles/:slug
  def show
    @article = Article.find_by!(slug: params[:slug])
  end
end