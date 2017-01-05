class Portfolio::ProjectsController < ApplicationController
  def index
    @portfolio_page = Page.find_by!(slug: 'portfolio')
    @projects = Project.where(is_hidden: false).order('position DESC')
  end
  
  def show
    @project = Project.find_by!(slug: params[:slug])
  end
end