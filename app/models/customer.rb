class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :billing_street, :billing_zip, :billing_city, :billing_country, :delivery_same, :delivery_street, :delivery_zip, :delivery_city, :delivery_country, :name, :surname, :company_name
  # attr_accessible :title, :body
  has_many :orders

  after_create :create_token
  
private
  
  def create_token
    self.reset_authentication_token!
  end

  def full_name
    return self.try(:name) + " " + self.try(:surname) unless name.present? || surname.present?
  end

end
