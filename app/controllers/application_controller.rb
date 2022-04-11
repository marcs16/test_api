class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

private

  def record_invalid(e)
    render json: {errors: e.errors}, status: :unprocessable_entity
  end
  def record_not_found(e)
    render json: {errors: e.message}, status: :not_found
  end

end
