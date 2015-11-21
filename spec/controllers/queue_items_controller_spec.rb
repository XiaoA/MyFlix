require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets the @queue_items variable to the queue items for the current user" do
      sherlock = Fabricate(:user)
      session[:user_id] = sherlock.id
      queue_item1 = Fabricate(:queue_item, user: sherlock)
      queue_item2 = Fabricate(:queue_item, user: sherlock)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "redirects to the sign_in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    it "redirects to the '+ My Queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    
    it "creates a queue item that is associated with the correct video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item that is associated with the current user" do
      sherlock = Fabricate(:user)
      session[:user_id] = sherlock.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(sherlock)
    end

    it "puts the new video at the last place in the queue" do
      sherlock = Fabricate(:user)
      session[:user_id] = sherlock.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: sherlock)
      arrow = Fabricate(:video)
      post :create, video_id: arrow.id
      arrow_queue_item = QueueItem.where(video_id: arrow.id, user_id: sherlock.id).first
      expect(arrow_queue_item.position).to eq(2)
    end

    it "does not add videos to the queue when they are already present in the queue" do
      sherlock = Fabricate(:user)
      session[:user_id] = sherlock.id
      arrow = Fabricate(:video)
      Fabricate(:queue_item, video: arrow, user: sherlock)
      post :create, video_id: arrow.id
      expect(sherlock.queue_items.count).to eq(1)
    end

    it "redirects to the sign_in page for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
end
