# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Anyone' do
  context 'can visit the about page' do
    it 'and see the ruby version' do
      visit '/about'
      expect(page).to have_content('Ruby: 3.1.0')
    end

    it 'and see the rails version' do
      visit '/about'
      expect(page).to have_content('Rails: 7')
    end

    it 'from homepage' do
      visit '/'
      click_on 'about'
      expect(page).to have_content('About')
    end
  end
end
