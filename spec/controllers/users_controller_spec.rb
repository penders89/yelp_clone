require 'spec_helper'

describe UsersController do 
  describe "GET new" do
    it "should assign @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of User
    end
  end
    
  describe "POST create" do
    context "with valid inputs" do 
      before do 
        post :create, user: { username: "Test", password: "password", 
          email: "test@example.com" }
      end  
      
      it "should create new user" do 
        expect(User.count).to eq(1)
      end
        
      it "should inform user of success" do 
        expect(flash[:success]).to be_present
      end
      
      it "should redirect to root" do
        expect(response).to redirect_to root_path
      end
    end
    
    context "with invalid inputs" do
      before do 
        post :create, user: { name: "name", password: "password" }
      end
      
      it "should not create a new user" do
        expect(User.count).to eq(0)
      end
      
      it "should render the new template" do 
        expect(response).to render_template :new
      end
    end
  end
end