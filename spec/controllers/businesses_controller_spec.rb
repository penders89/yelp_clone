require 'spec_helper'

describe BusinessesController do
  
  describe "GET index" do
    it "sets @businesses variable" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to eq([business1, business2])
    end
  end
  
  describe "GET show" do 
    it "sets @business variable" do 
      business1 = Fabricate(:business)
      get :show, id: business1.id
      expect(assigns(:business)).to eq(business1)
    end
  end
  
  describe "GET new" do 
    it "sets @business variable" do 
      get(:new)
      expect(assigns(:business)).to be_instance_of(Business)
    end
  end
  
  describe "POST new" do 
    context "with valid inputs" do
      before do 
        post :create, business: { name: "New business",
          price: 3, description: "new business description" }
      end
      
      it "saves new business" do
        expect(Business.count).to eq(1)
      end
      
      it "informs user" do 
        expect(flash[:success]).to be_present
      end
      
      it "redirects to view page of that business" do
        expect(response).to redirect_to business_path(Business.first)
      end
    end
    
    context "with invalid inputs" do 
      before do 
        post :create, business: { name: "New business",
          price: 3 }
      end
      
      it "renders the new template" do
        expect(response).to render_template :new
      end  
      
      it "sets @business variable" do
        expect(assigns(:business)).to be_instance_of(Business)
      end
    end
  end
end