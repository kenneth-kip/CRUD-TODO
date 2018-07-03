class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Response
  include ExceptionHandler

  before_action :authenticate_user!
  # attr_reader :current_user

  private

  # # Check for valid request token and return user
  # def authorize_request
  #   @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  # end
end
