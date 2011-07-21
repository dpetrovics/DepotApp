require 'digest/sha2'

class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true 
  attr_accessor :password_confirmation 
  attr_reader :password

  validate :password_must_be_present
  
  #class methods
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)    #secure hash algorithm
  end
  
  def User.authenticate(name, password)
    if user = find_by_name(name)  #this is a dynamic finder method (Active Record trick)
      if user.hashed_password == encrypt_password(password, user.salt)
        user  #the name and password match, so return the user object
      end
    end
  end
  
  #this is the setter for @password, getter is defined via attr_reader above
  #it sets the hashed password using a salt. password is a 'virtual' attribute
  def password=(password)
    @password = password
    
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  private
    #check to make sure the password is there
    def password_must_be_present 
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
    
    def generate_salt   #a salt is an unpredictable string
      #self. makes sure were not just assigning to a local variable 
      #but to the salt property of this User instance
      self.salt = self.object_id.to_s + rand.to_s 
    end
end