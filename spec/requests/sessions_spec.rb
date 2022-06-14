# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before do
    User.create!(email: 'test@test.com', password: '123456')
  end
  let(:signin_user) do
    post signin_path, params: { user: { email: 'test@test.com',
                                        password: '123456' } }
  end
  describe 'GET /signin' do
    context 'successfully' do
      it 'when returns a success response' do
        get signin_path
        expect(response).to be_successful
      end
    end
    context 'unsuccessfully' do
      it ' when returns a success response' do
        @user = User.first
        get signin_path
        expect(response).to be_successful
      end
    end
  end
  describe 'POST /signin' do
    context 'successfully' do
      it 'when returns a success response' do
        signin_user
        expect(response).not_to include('Invalid email/password')
      end
    end
    context 'unsuccessfully' do
      it 'when returns a success response' do
        post signin_path, params: { user: { email: 'test@test',
                                            password: '123456' } }
        expect(response.body).to include('Invalid email/password')
      end
    end
  end
  describe 'DELETE /signout' do
    context 'successfully' do
      it 'when session[:user_id] return nil' do
        signin_user
        delete signout_path
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
