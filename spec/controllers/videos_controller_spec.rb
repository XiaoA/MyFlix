require 'spec_helper'

describe VideosController do
  describe "GET show" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end 
    end
    
    it "renders the show template" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to render_template :show
    end
  end
end

