class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.where(is_hidden: false).where.not(published_at: nil).order('position DESC')
  end
  
  def taged_index
    if Tag.exists?(slug: params[:tag_slug])
      @articles = Article.joins(:tags).where(tags: { slug: params[:tag_slug] }, is_hidden: false).where.not(published_at: nil).order('position DESC')
    else
      redirect_to articles_path
    end
  end
  
  # GET /articles/:slug
  def show
    @article = Article.find_by!(slug: params[:slug])
  end
  
  # GET /feed
  def feed
    @articles = Article.where(is_hidden: false).where.not(published_at: nil).order('position DESC').limit(10)
    render 'articles/feed', layout: false
  end
end
