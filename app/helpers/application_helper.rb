module ApplicationHelper
  def average_rating(reviews)
    (reviews.map(&:rating).inject{ |sum, el| sum + el }.to_f / (reviews.size)).round(2)
    
  end
end
