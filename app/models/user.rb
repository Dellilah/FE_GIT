class User < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_one :visibility
  attr_protected :admin
  attr_protected :moderator
  acts_as_authentic do |config|
    config.crypted_password_field = :crypted_password
    config.require_password_confirmation = true
  end
  has_many :comments
  
  validates :login, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :name, :presence => true, :length => { :in => 2..20 }, :format => { :with => /\A[a-zA-Z]+\z/ }
  validates :surname, :presence => true, :length => { :in => 2..20 }, :format => { :with => /\A[a-zA-Z]+\z/ }
  
  mount_uploader :avatar_url, AvatarUploader
end
