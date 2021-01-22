class Api::React::TagsController < Api::React::ApiController
  # GET api/react/tags
  def index
    tags = Tag.order("LOWER(title) ASC")
    render json: tags, each_serializer: TagSerializer, status: :ok
  end
  
  # GET api/react/tags/:id
  def show
    tag = Tag.find(params[:id])
    render json: tag, serializer: TagSerializer, status: :ok
  end
  
  # POST api/react/tags
  def create
    if tag.save
      render json: tag, serializer: TagSerializer, status: :ok
    else
      render json: { errors: tag.errors.full_messages }, status: :bad_request
    end
  end
  
  # PUT/PATCH api/react/tags/:id
  def update
    tag = Tag.find(params[:id])
    
    if tag.update(tag_params)
      render json: tag, serializer: TagSerializer, status: :ok
    else
      render json: { errors: tag.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/tags/:id
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    render json: {}, status: :ok
  end
  
  private
    def tag_params
      params.require(:tag).permit(:title)
    end
end
