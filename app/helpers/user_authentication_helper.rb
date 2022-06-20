# frozen_string_literal: true

# This module is for User authentication methods
module UserAuthenticationHelper
  def current_user
    @user ||= (User.find_by(id: session[:user_id]) if session[:user_id])
  end

  def user_signed_in?
    !!current_user
  end

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = 'Ops! você deve estar logado para realizar tal ação'
      redirect_to signin_path, status: :unauthorized
    end
  end

  def redirect_if_already_signed_in
    redirect_to root_path, status: 307 if user_signed_in?
  end

  def any_user_already_registered?
    User.any?
  end

  def redirect_if_theres_already_a_user_registered
    redirect_to root_path, status: 307 if any_user_already_registered?
  end
end
