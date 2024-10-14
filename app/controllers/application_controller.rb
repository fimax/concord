class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found(exp)
    render json: { errors: [exp.message] }, status: :not_found
  end
end
