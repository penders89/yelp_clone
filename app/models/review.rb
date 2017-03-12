class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  
  validates_presence_of :content
  validates_presence_of :rating
    validates_numericality_of :rating, {only_integer: true, 
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    
  default_scope { order(created_at: :desc) }

end