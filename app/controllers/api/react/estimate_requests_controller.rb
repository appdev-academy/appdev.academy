class Api::React::EstimateRequestsController < Api::React::ApiController
  # GET /api/react/estimate_requests
  def index
    estimate_requests = EstimateRequests.all
    render json: estimate_requests, each_serializer: EstimateRequestIndexSerializer, status: :ok
  end
end
