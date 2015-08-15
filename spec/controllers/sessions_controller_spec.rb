require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    
    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      let(:user) { Fabricate(:user) }
          
      it "puts the signed-in user in the session" do
        post :create, email: user.email, password: user.password
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the home page" do
        post :create, email: user.email, password: user.password
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do
        post :create, email: user.email, password: user.password
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      let(:user) { Fabricate(:user) }
      before do
        post :create, email: user.email, password: user.password + 'asdfghjkl'        
      end

      it "does not create a new session for the user" do
        post :create, email: user.email, password: user.password + 'asdfghjkl'        
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign_in page" do
        post :create, email: user.email, password: user.password + 'asdfghjkl'        
        get :new
        expect(response).to render_template :new
      end

      it "sets the error message" do
        post :create, email: user.email, password: user.password + 'asdfghjkl'        
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy      
    end

    it "clears out the session for the user" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "set the notice" do
      expect(flash[:success]).not_to be_nil
    end
  end
end
