
class User < ActiveRecord::Base
  has_many :urls
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  def self.autentic(email, password) 
   User.find_by(email: email, password: password)
  end
end


