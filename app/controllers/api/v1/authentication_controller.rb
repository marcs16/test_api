class Api::V1::AuthenticationController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    if params[:user].nil?
      render json: {errors: 
        "param is missing or the value is empty: email, param is missing or the value is empty: password"},
         status: :unprocessable_entity
    else
       if params[:user][:email].present? && params[:user][:password].present?
        render json: {token: "123"}, status: :created
      elsif params[:user][:email].blank?
        params.require(:email)
      elsif params[:user][:password].blank?
        params.require(:password)
      end
    end
  end

  private

  def parameter_missing(e)
    render json: {errors: e.message}, status: :unprocessable_entity
  end
end