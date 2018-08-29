class AdminController < ApplicationController
  layout 'admin'
  
  def index
    @hello_world_props = { name: 'Stranger' }
  end
end
