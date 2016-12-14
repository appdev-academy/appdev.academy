class Api::React::ArticlesController < Api::React::ApiController
  skip_before_action :authenticate_user, only: [:index, :show]
  
  # GET api/react/articles
  def index
    articles = Article.order('position DESC')
    render json: articles, each_serializer: ArticleIndexSerializer, status: :ok
  end
  
  # GET api/react/articles/:id
  def show
    article = Article.find(params[:id])
    render json: article, serializer: ArticleShowSerializer, status: :ok
  end
  
  # POST api/react/articles
  def create
    article = Article.new(article_params)
    if article.save
      render json: article, serializer: ArticleShowSerializer, status: :ok
    else
      render json: { errors: article.errors.full_messages }, status: :bad_request
    end
  end
  
  # PUT/PATCH api/react/articles/:id
  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article, serializer: ArticleShowSerializer, status: :ok
    else
      render json: { errors: article.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/articles/:id
  def destroy
    article = Article.find(params[:id])
    article.destroy
    render json: {}, status: :ok
  end
  
  # POST api/react/articles/:id/publish
  def publish
    article = Article.find(params[:id])
    # Publish `Article`
    if article.published_at
      # If `Article` is already published - change visibility
      article.is_hidden = false
    else
      # `Article` is published for the first time - set published_at date
      article.published_at = Date.current
    end
    if article.save
      render json: article, serializer: ArticleShowSerializer, status: :ok
    else
      render json: { errors: article.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/articles/:id/hide
  def hide
    article = Article.find(params[:id])
    # Publish `Article`
    article.is_hidden = true
    if article.save
      render json: article, serializer: ArticleShowSerializer, status: :ok
    else
      render json: { errors: article.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/articles/sort
  def sort
    params[:article_ids].reverse.each_with_index do |id, index|
      Article.where(id: id).update_all(position: index + 1)
    end
    render json: {}, status: :ok
  end
  
  private
  
    def article_params
      params.require(:article).permit(:content, :html_content, :html_preview, :preview, :title)
    end
end