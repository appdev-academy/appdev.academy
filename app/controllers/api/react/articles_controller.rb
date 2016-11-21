class API::React::ArticlesController < API::React::ApiController
  
  # GET api/react/articles
  def index
    articles = Articles.all
    articles_json = ActiveModel::Serializer::CollectionSerializer.new(articles, each_serializer: ArticleSerializer).as_json
    render json: { articles: articles_json }, status: :ok
  end
  
  # GET api/react/articles/:id
  def show
    article = Article.find(params[:id])
    article_json = ArticleSerializer.new(article).attributes.as_json
    render json: { article: article_json }, status: :ok
  end
  
  # POST api/react/articles
  def create
    article = Article.new(article_params)
    if article.save
      article_json = ArticleSerializer.new(article).attributes.as_json
      render json: { article: article_json }, status: :ok
    else
      render json: { errors: article.errors.full_messages }, status: :bad_request
    end
  end
  
  # PUT/PATCH api/react/articles/:id
  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      article_json = ArticleSerializer.new(article).attributes.as_json
      render json: { article: article_json }, status: :ok
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