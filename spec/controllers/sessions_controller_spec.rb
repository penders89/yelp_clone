require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "with valid input" do 
      let(:user) { Fabricate(:user) }
      
      before do 
        post :create, email: user.email, password: user.password
      end
      
      it "should set the session variable" do 
        expect(session[:user_id]).to eq(user.id)
      end
      
      it "should redirect to the root page" do
        expect(response).to redirect_to root_path 
      end
      
      it "should inform the user about being logged in" do 
        expect(flash[:success]).to be_present
      end
    end 
    
    context "with invalid input" do 
      let(:user) { Fabricate(:user) }
      
      before do 
        post :create, email: user.email, password: 'wrongpass'
      end
      
      it "should render the new template" do 
        expect(response).to render_template :new
      end
      
      it "should inform the user something is wrong" do 
        expect(flash.now[:danger]).to be_present
      end
    end
  end
  
  describe "DELETE destroy" do 
    let(:user) { Fabricate(:user) }
    
    before do 
      session[:user_id] = user.id
      delete :destroy
    end
    
    it "should remove the session variable" do 
      expect(session[:user_id]).to eq(nil)
    end
    
    it "should redirect to the root path" do 
      expect(response).to redirect_to root_path
    end
    
    it "should inform the user of being logged out" do 
      expect(flash[:success]).to be_present
    end
  end
end