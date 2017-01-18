class Api::React::ScreencastsController < Api::React::ApiController
  # GET api/react/topics/:topic_id/screencasts
  def index
    screencasts = Screencast.where(topic_id: params[:topic_id]).order('position DESC')
    render json: screencasts, each_serializer: ScreencastIndexSerializer, status: :ok
  end
  
  # GET api/react/screencasts/:id
  def show
    screencast = Screencast.find(params[:id])
    render json: screencast, serializer: ScreencastShowSerializer, status: :ok
  end
  
  # POST api/react/topics/:topic_id/screencasts
  def create
    topic = Topic.find(params[:topic_id])
    screencast = Screencast.new(screencast_params)
    screencast.topic = topic
    if screencast.save
      render json: screencast, serializer: ScreencastShowSerializer, status: :ok
    else
      render json: { errors: screencast.errors.full_messages }, status: :bad_request
    end
  end
  
  # PUT/PATCH api/react/screencasts/:id
  def update
    screencast = Screencast.find(params[:id])
    if screencast.update(screencast_params)
      render json: screencast, serializer: ScreencastShowSerializer, status: :ok
    else
      render json: { errors: screencast.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/screencasts/:id
  def destroy
    screencast = Screencast.find(params[:id])
    screencast.destroy
    render json: {}, status: :ok
  end
  
  # POST api/react/screencasts/:id/publish
  def publish
    screencast = Screencast.find(params[:id])
    screencast.is_hidden = false
    if screencast.save
      render json: screencast, serializer: ScreencastShowSerializer, status: :ok
    else
      render json: { errors: screencast.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/screencasts/:id/hide
  def hide
    screencast = Screencast.find(params[:id])
    screencast.is_hidden = true
    if screencast.save
      render json: screencast, serializer: ScreencastShowSerializer, status: :ok
    else
      render json: { errors: screencast.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/topics/:topic_id/screencasts/sort
  def sort
    params[:screencast_ids].reverse.each_with_index do |id, index|
      Screencast.where(id: id).update_all(position: index + 1)
    end
    render json: {}, status: :ok
  end
  
  private
    def screencast_params
      params.require(:screencast).permit(:content, :html_content, :html_preview, :image_url, :preview, :short_description, :title)
    end
end
