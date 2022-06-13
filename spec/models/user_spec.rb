# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:password) { '123456' }
  subject { described_class.create(email: 'user@test.com', password:) }

  describe 'authenticate' do
    context 'successfully' do
      it 'when right password' do
        expect(subject.authenticate(password)).to equal(subject)
      end
    end
    context 'unsuccessfully' do
      it 'when wrong password' do
        expect(subject.authenticate('wrong')).not_to equal(subject)
      end
    end
  end
  describe 'register' do
    context 'successfully' do
      it 'when password has more or equal 6 characters' do
        subject = described_class.new(email: 'user@test.com',
                                      password: '123456')
        expect(subject.valid?).to be_truthy
      end
      it 'when email is set' do
        subject = described_class.new(email: 'user@test.com',
                                      password: '123456')
        expect(subject.valid?).to be_truthy
      end
      it 'when email is a valid email regex' do
        subject = described_class.new(email: 'user@test.com',
                                      password: '123456')
        expect(subject.valid?).to be_truthy
      end
    end
    context 'unsuccessfully' do
      it 'when password has less than 6 characters' do
        subject = described_class.new(email: 'user@test.com',
                                      password: '12345')
        expect(subject.valid?).to be_falsy
        expect(subject.errors.full_messages).to include('Password is too short')
      end
      it 'when email is blank' do
        subject = described_class.new(password: '123456')
        expect(subject.valid?).to be_falsy
      end
      it 'when email is not a valid email regex' do
        subject = described_class.new(email: 'usertest.com',
                                      password: '123456')
        expect(subject.valid?).to be_falsy
      end
    end
  end
end
