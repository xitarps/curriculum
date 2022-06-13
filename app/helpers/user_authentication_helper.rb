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
    return redirect_to root_path, status: :ok if user_signed_in?
  end
end
