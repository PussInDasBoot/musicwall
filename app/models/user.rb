require 'bcrypt'

class User < ActiveRecord::Base
  has_many :songs
  has_many :votes
  has_many :reviews
  
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

  include BCrypt


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end