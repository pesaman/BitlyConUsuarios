require 'securerandom'
require 'uri'
class Url < ActiveRecord::Base
  
  # Remember to create a migration!
  before_create :get_short_url 

  def get_short_url
    random = SecureRandom.hex(2)
    self.short_url = "http://" + random
  
  end  

  def self.valid_url?(url)

    #this, validates unput url user
    uri = URI.parse(url)
    return uri.is_a?(URI::HTTP) && !uri.host.nil?
  end
end