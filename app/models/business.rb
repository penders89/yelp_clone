class Business < ActiveRecord::Base 
  self.per_page = 8
  
  validates_presence_of :name
  validates_presence_of :description
  
  has_many :reviews, -> { order('created_at desc') }

  
  validates_presence_of :price
  validates_numericality_of :price, {only_integer: true, 
    greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }
  
end