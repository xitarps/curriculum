# frozen_string_literal: true

require 'rails_helper'

describe 'Anyone' do
  it 'can visit the home page' do
    visit '/'
    expect(page).to have_content('Welcome to the Home Page')
  end
end
