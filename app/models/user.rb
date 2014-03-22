class User < ActiveRecord::Base
  has_secure_password
  
  validates_uniqueness_of :name

  has_many :recipes
  has_many :comments
  has_many :friendships
  has_many :friends, through: :friendships
end
