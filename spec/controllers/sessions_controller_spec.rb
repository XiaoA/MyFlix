require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "render the new template for unauthenticated users" do
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
      it "puts the signed-in user in the session" do
        andrew = Fabricate(:user)
        post :create, email: andrew.email, password: andrew.password
        expect(session[:user_id]).to eq(andrew.id)
      end

      it "redirects to the home page" do
        andrew = Fabricate(:user)
        post :create, email: andrew.email, password: andrew.password
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do
        andrew = Fabricate(:user)
        post :create, email: andrew.email, password: andrew.password
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      it "does not create a new session for the user" do
        andrew = Fabricate(:user)
        post :create, email: andrew.email, password: andrew.password + 'asdfghjkl'
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign_in page" do
        andrew = Fabricate(:user)
        post :create, email: andrew.email, password: andrew.password + 'asdfghjkl'
        get :new
        expect(response).to render_template :new
      end

      it "sets the error message" do
        andrew = Fabricate(:user)
        post :create, email: andrew.email, password: andrew.password + 'asdfghjkl'
        expect(flash[:danger]).not_to be_blank
      end
    end
  end
end

