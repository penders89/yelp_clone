class User < ActiveRecord::Base

  before_validation :downcase_email
  
  has_secure_password validations: false
  has_many :reviews, -> { order('created_at desc') }
  
  validates_presence_of :username
  
  validates_presence_of :email
  validates_uniqueness_of :email
  
  validates_presence_of :password, on: [:create]
  validates_length_of :password, minimum: 8, maximum: 20
  
  private
    def downcase_email
      self.email = email.downcase if email
    end
  
end