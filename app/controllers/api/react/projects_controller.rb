class Api::React::ProjectsController < Api::React::ApiController
  # GET api/react/projects
  def index
    projects = Project.order('position DESC')
    render json: projects, each_serializer: ProjectIndexSerializer, status: :ok
  end
  
  # GET api/react/projects/:id
  def show
    project = Project.find(params[:id])
    render json: project, serializer: ProjectShowSerializer, status: :ok
  end
  
  # POST api/react/projects
  def create
    project = Project.new(project_params)
    
    # Update tags
    update_tags_for_project(project)
    
    if project.save
      render json: project, serializer: ProjectShowSerializer, status: :ok
    else
      render json: { errors: project.errors.full_messages }, status: :bad_request
    end
  end
  
  # PUT/PATCH api/react/projects/:id
  def update
    project = Project.find(params[:id])
    
    # Update tags
    update_tags_for_project(project)
    
    if project.update(project_params)
      render json: project, serializer: ProjectShowSerializer, status: :ok
    else
      render json: { errors: project.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/projects/:id
  def destroy
    project = Project.find(params[:id])
    project.destroy
    render json: {}, status: :ok
  end
  
  # POST api/react/projects/:id/publish
  def publish
    project = Project.find(params[:id])
    # Publish `Project`
    project.is_hidden = false
    if project.save
      render json: project, serializer: ProjectShowSerializer, status: :ok
    else
      render json: { errors: project.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/projects/:id/hide
  def hide
    project = Project.find(params[:id])
    # Publish `Project`
    project.is_hidden = true
    if project.save
      render json: project, serializer: ProjectShowSerializer, status: :ok
    else
      render json: { errors: project.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/projects/sort
  def sort
    params[:project_ids].reverse.each_with_index do |id, index|
      Project.where(id: id).update_all(position: index + 1)
    end
    render json: {}, status: :ok
  end
  
  private
    def project_params
      params.require(:project).permit(:app_icon, :content, :html_content, :html_preview, :preview, :title)
    end
    
    def update_tags_for_project(project)
      tags_titles = params[:tags_titles]
      puts 'tags_titles: ' + tags_titles
      if tags_titles
        tags = []
        tags_titles.split(',').each do |tag_title|
          tag = Tag.where('lower(title) = lower(?)', tag_title).first
          if tag.nil?
            tag = Tag.create(title: tag_title)
          end
          tags << tag
        end
        project.tags = tags
      end
    end
end
