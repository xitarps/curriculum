# frozen_string_literal: true

# This class is about User and authentication
class User < ApplicationRecord
  include UserAuthenticationHelper
  has_secure_password

  validates_length_of :password, minimum: 6, message: 'is too short'
  validates_presence_of :password, :email, message: 'can\'t be blank'
  mail_regex = /\A(\S+)@(.+)\.(\S+)\z/
  validates_format_of :email, with: mail_regex, message: 'is invalid'
  validate lambda {
    errors.add(:user, 'already registered any') if any_user_already_registered?
  }, on: :create
  # before_create lambda {
  #   errors.add(:user, 'already registered one')
  #   raise 'ERROR'
  # }, if: :any_user_already_registered?
end
