class ScreencastsController < ApplicationController
  def index
    @screencasts_page = Page.find_by!(slug: 'screencasts')
    @topics = Topic.where(is_hidden: false).order('position DESC')
  end
  
  def show
    @screencast = Screencast.find_by!(slug: params[:slug])
  end
end
