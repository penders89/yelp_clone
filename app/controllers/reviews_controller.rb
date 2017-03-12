class ReviewsController < ApplicationController
  before_action :require_login
  
  def create
    @business = Business.find(params[:business_id])
    @reviews = @business.reviews
    
    @review = Review.new(review_params)
    @review.business = @business
    @review.user = current_user
    
    if @review && @review.save 
      flash[:success] = "Thanks for your review."
      redirect_to business_path(@business) 
    else
      flash.now[:danger] = "Sorry we could not create the review."
      render 'businesses/show'
    end
  end
  
  private
    def review_params
      params.permit(:content, :rating)
    end
    
    def require_login
      if !logged_in?
        flash[:danger] = "You must be logged in to do that."
        redirect_to login_path
      end
    end
  
end