require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @review for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review_1 = Fabricate(:review, video: video)
      review_2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review_1, review_2])
    end

    it "redirects the user to the sign in page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      monk = Fabricate(:video, title: 'Monk')
      post :search, search_term: 'onk'
      expect(assigns(:results)).to eq([monk])
    end

    it "redirectos to sign in page for unauthenticated users" do
      monk = Fabricate(:video, title: 'Monk')
      post :search, search_term: 'onk'
      expect(response).to redirect_to sign_in_path
    end
  end
end

