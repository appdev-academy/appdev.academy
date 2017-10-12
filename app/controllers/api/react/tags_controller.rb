class Api::React::TagsController < Api::React::ApiController
  # GET api/react/tags
  def index
    tags = Tag.all
    render json: tags, each_serializer: TagSerializer, status: :ok
  end
  
  # PUT/PATCH api/react/tags/:id
  def update
    tag = tag.find(params[:id])
    
    if tag.update(tag_params)
      render json: tag, serializer: TagSerializer, status: :ok
    else
      render json: { errors: tag.errors.full_messages }, status: :bad_request
    end
  end
  
  private
    def tag_params
      params.require(:tag).permit(:title)
    end
end
