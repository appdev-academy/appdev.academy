class Api::React::ArticleImagesController < Api::React::ApiController
  
  # GET api/react/article_images
  def index
    article_images = ArticleImage.order('id DESC')
    render json: article_images, each_serializer: ArticleImageSerializer, status: :ok
  end
  
  # POST api/react/article_images
  def create
    article_image = ArticleImage.new(article_image_params)
    if article_image.save
      render json: article_image, serializer: ArticleImageSerializer, status: :ok
    else
      render json: { errors: article_image.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/article_images/:id
  def destroy
    article_image = ArticleImage.find(params[:id])
    article_image.destroy
    render json: {}, status: :ok
  end
  
  private
  
    def article_image_params
      params.require(:article_image).permit(:image)
    end
end