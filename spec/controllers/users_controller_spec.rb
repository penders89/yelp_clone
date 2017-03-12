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
  
  describe "GET show" do 
    let(:user) { Fabricate(:user) }
    let(:review1) { Fabricate(:review, user: user, created_at: 2.days.ago) }
    let(:review2) { Fabricate(:review, user: user, created_at: 1.days.ago) }
    
    before do 
      get :show, id: user.id
    end
    
    it "should set the @user variable" do 
      expect(assigns(:user)).to eq(user)
    end
    
    it "should set the @reviews variable in reverse chronological order" do 
      expect(assigns(:reviews)).to eq([review2, review1])
    end
  end
end