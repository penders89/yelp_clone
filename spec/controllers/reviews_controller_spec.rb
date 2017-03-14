require 'spec_helper'

describe ReviewsController do 
  describe "GET index" do 
    it "should set the @reviews variable in reverse chronological order" do 
      review1 = Fabricate(:review, created_at: 2.days.ago)
      review2 = Fabricate(:review, created_at: 1.days.ago)
      get :index
      expect(assigns(:reviews)).to eq([review2, review1])
    end   
    
  end
  
  describe "POST create" do 
    let(:user) { Fabricate(:user) }
    let(:business) { Fabricate(:business) }

    context "with valid inputs and authenticated user" do 
      before do 
        session[:user_id] = user.id
        post :create, business_id: business.id, 
          content: "Review content", rating: 5 
      end
      
      it "should create the review" do 
        expect(Review.count).to eq(1)
      end
      
      it "should associate the review with the user" do 
        expect(Review.first.user).to eq(user) 
      end
      
      it "should associate the review with the business" do 
        expect(Review.first.business).to eq(business) 
      end
      
      it "should inform the user the review has been created" do 
        expect(flash[:success]).to be_present
      end
      
      it "should redirect to the business page" do 
        expect(response).to redirect_to business_path(business)
      end
    end
    
    context "with invalid inputs and authenticated user" do 
      before do 
        session[:user_id] = user.id
        post :create, business_id: business.id,
          content: "Review content", rating: 8 
      end
      
      it "should not create the review" do 
        expect(Review.count).to eq(0)
      end
      
      it "should render the business page" do 
        expect(response).to render_template 'businesses/show'
      end
      
      it "should inform the user that the review has not been created" do 
        expect(flash.now[:danger]).to be_present
      end
    end
    
    context "without authenticated user" do 
      before do 
        post :create, business_id: business.id, 
          content: "Review content", rating: 3
      end
      
      it "should not create the review" do 
        expect(Review.count).to eq(0)
      end
      
      it "should redirect to login page" do
        expect(response).to redirect_to login_path
      end
      
      it "should inform user of invalid action" do 
        expect(flash[:danger]).to be_present
      end
    end
  end
end