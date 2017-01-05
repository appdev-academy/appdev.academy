class Portfolio::ProjectsController < ApplicationController
  def index
    @projects = Project.where(is_hidden: false).order('position DESC')
  end
  
  def show
    @project = Project.find_by!(slug: params[:slug])
  end
end