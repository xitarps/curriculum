# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'redirect_to' do
  def redirect_to(path, _status)
    path
  end

  # self.class_eval {
  #   define_method :redirect_to do |path, status|
  #     401
  #   end
  # }
end

RSpec.describe UserAuthenticationHelper do
  let(:user) { User.create!(email: 'user@test.com', password: '123456') }
  describe 'current_user method' do
    context 'return successfully a user' do
      it 'when session is set and @user is not' do
        @user = nil
        session[:user_id] = user.id

        expect(current_user).to eql(user)
      end
      it 'when @user is set and session is not set' do
        @user = user
        session[:user_id] = nil

        expect(current_user).to eql(user)
      end
    end
    context 'return unsuccessfully a user/ return nil' do
      it 'when session and @user are not set' do
        @user = nil
        session[:user_id] = nil

        expect(current_user).not_to eql(user)
      end
    end
  end
  describe 'user_signed_in? method' do
    context 'return true' do
      it 'when current_user returns user' do
        @user = user

        expect(user_signed_in?).to be_truthy
      end
    end
    context 'return false' do
      it 'when current_user returns nil' do
        @user = nil

        expect(user_signed_in?).to be_falsey
      end
    end
  end
  describe 'authenticate_user! method' do
    include_context 'redirect_to'
    context 'doesen\'t redirect ' do
      it 'when current_user returns user' do
        @user = user

        expect(authenticate_user!).not_to eql('/signin')
      end
    end
    context 'redirect to new_session_path' do
      it 'when current_user returns nil' do
        expect(authenticate_user!).to eql('/signin')
      end
    end
  end
  describe 'any_user_already_registered? method' do
    context 'return false' do
      it 'when theres none user already registered' do
        expect(any_user_already_registered?).to be_falsey
      end
    end
    context 'return true' do
      it 'when theres any user already registered' do
        @user = user

        expect(any_user_already_registered?).to be_truthy
      end
    end
  end
  describe 'redirect_if_already_signed_in method' do
    include_context 'redirect_to'
    context 'doesen\'t redirect ' do
      it 'when user_signed_in? returns false' do
        expect(redirect_if_already_signed_in).not_to eql('/')
      end
    end
    context 'redirect ' do
      it 'when user_signed_in? returns true' do
        @user = user

        expect(redirect_if_already_signed_in).to eql('/')
      end
    end
  end

  describe 'redirect_if_theres_already_a_user_registered method' do
    include_context 'redirect_to'
    context 'doesen\'t redirect ' do
      it 'when any_user_already_registered? returns false' do
        expect(redirect_if_theres_already_a_user_registered).not_to eql('/')
      end
    end
    context 'redirect ' do
      it 'when any_user_already_registered? returns true' do
        @user = user

        expect(redirect_if_theres_already_a_user_registered).to eql('/')
      end
    end
  end
end
