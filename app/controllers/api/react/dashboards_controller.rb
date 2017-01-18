class Api::React::DashboardsController < Api::React::ApiController
  # GET /api/react/dashboards/main
  def main
    json_object = {
      articles: {
        total: Article.count,
        published: Article.where.not(published_at: nil).where(is_hidden: false).count,
        hidden: Article.where.not(published_at: nil).where(is_hidden: true).count,
        drafts: Article.where(published_at: nil).count
      }
    }
    render json: json_object, status: :ok
  end
end
