class Api::React::GalleryImagesController < Api::React::ApiController
  
  # GET api/react/projects/:project_id/gallery_images
  def index
    project = Project.find(params[:project_id])
    render json: project.gallery_images, each_serializer: GalleryImageSerializer, status: :ok
  end
  
  # POST api/react/projects/:project_id/gallery_images
  def create
    project = Project.find(params[:project_id])
    
    gallery_image = GalleryImage.new(gallery_image_params)
    gallery_image.project = project
    if gallery_image.save
      render json: gallery_image, serializer: GalleryImageSerializer, status: :ok
    else
      render json: { errors: gallery_image.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/gallery_images/:id
  def destroy
    gallery_image = GalleryImage.find(params[:id])
    gallery_image.destroy
    render json: {}, status: :ok
  end
  
  # POST api/react/gallery_images/sort
  def sort
    params[:gallery_image_ids].reverse.each_with_index do |id, index|
      GalleryImage.where(id: id).update_all(position: index + 1)
    end
    render json: {}, status: :ok
  end
  
  private
    def gallery_image_params
      params.require(:gallery_image).permit(:image)
    end
end
