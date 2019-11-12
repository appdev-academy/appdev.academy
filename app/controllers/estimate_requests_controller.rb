class EstimateRequestsController < ApplicationController
  # GET /request-estimate
  def new
    @estimate_request = EstimateRequest.new
  end
  
  # POST /request-estimate
  def create
    @estimate_request = EstimateRequest.new(estimate_request_params)
    if @estimate_request.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  private
    def estimate_request_params
      params.require(:estimate_request).permit(:budget, :company, :deadline, :details, :documen, :email, :is_admin_panel, :is_android, :is_backend_api, :is_design, :is_ios, :is_other, :name, :subject)
    end
end
