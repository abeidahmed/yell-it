class SessionsController < ApplicationController
  def new; end

  def create
    auth = Authentication.new(params)

    if auth.authenticated?
      sign_in(auth.user)
      redirect_to root_path
    else
      render json: { errors: { invalid: ["credentials"] } }, status: :unprocessable_entity
    end
  end
end
