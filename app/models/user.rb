# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # devise :omniauthable, omniauth_providers: [:google_oauth2]

  include DeviseTokenAuth::Concerns::User

  pay_customer default_payment_processor: ENV.fetch('PAYMENT_PROCESSOR').to_sym

  has_many :name_based_generated_logs

end
