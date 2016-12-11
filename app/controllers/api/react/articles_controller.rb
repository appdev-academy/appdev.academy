class Api::React::ArticlesController < Api::React::ApiController
  skip_before_action :authenticate_user, only: [:index, :show]
  
  # GET api/react/articles
  def index
    articles = Article.order('id DESC')
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
  
  private
  
    def article_params
      params.require(:article).permit(:content, :html_content, :title)
    end
end