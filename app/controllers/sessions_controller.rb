# frozen_string_literal: true

# This class is for User sessions authentication methods
class SessionsController < ApplicationController
  include UserAuthenticationHelper
  before_action :redirect_if_already_signed_in, only: %i[new create]

  def new
    redirect_if_already_signed_in
    @session = User.new
  end

  def create
    user = User.find_by(email: user_params[:email].downcase)
    if user&.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password'
      @session = User.new(email: user_params)

      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    @user = nil
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
