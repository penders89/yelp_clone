require 'spec_helper'

describe BusinessesController do
  
  describe "GET index" do
    it "sets @businesses variable" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to eq([business1, business2])
    end
    
    it "only returns 8 businesses" do 
      arr = []
      9.times { arr.push(Fabricate(:business)) }
      arr.pop
      get :index
      expect(assigns(:businesses)).to match_array(arr)
    end
  end
  
  describe "GET show" do 
    let(:business) { Fabricate(:business) } 
    let(:review1) { Fabricate(:review, business: business, created_at: 2.days.ago) }
    let(:review2) { Fabricate(:review, business: business, created_at: 1.days.ago) }
    
    before do 
      get :show, id: business.id
    end

    
    it "sets @business variable" do 
      expect(assigns(:business)).to eq(business)
    end
    
    it "sets @reviews variable ordered from most recent to oldest" do 
      expect(assigns(:reviews)).to eq([review2, review1])
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