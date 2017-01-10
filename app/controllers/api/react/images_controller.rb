class Api::React::ImagesController < Api::React::ApiController
  # GET api/react/images
  def index
    images = Image.order('id DESC')
    render json: images, each_serializer: ImageSerializer, status: :ok
  end
  
  # POST api/react/images
  def create
    image = Image.new(image_params)
    if image.save
      render json: image, serializer: ImageSerializer, status: :ok
    else
      render json: { errors: image.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/images/:id
  def destroy
    image = Image.find(params[:id])
    image.destroy
    render json: {}, status: :ok
  end
  
  private
    def image_params
      params.require(:image).permit(:image)
    end
end