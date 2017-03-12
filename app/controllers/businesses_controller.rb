class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end
  
  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews
  end
  
  def new
    @business = Business.new
  end
   
  def create
    @business = Business.new(business_params)
    
    if @business && @business.save
      flash[:success] = "New business created."
      redirect_to business_path(@business)
    else
      render 'new'
    end
    
  end
  
  private
    def business_params
      params.require(:business).permit(:name, :price, :description)
    end
end