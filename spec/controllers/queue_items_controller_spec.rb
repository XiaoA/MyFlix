require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets the @queue_items variable to the queue items for the current user" do
      sherlock = Fabricate(:user)
      set_current_user(sherlock)
      session[:user_id] = sherlock.id
      queue_item1 = Fabricate(:queue_item, user: sherlock)
      queue_item2 = Fabricate(:queue_item, user: sherlock)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

  
  describe "POST create" do
    it "redirects to the 'My Queue' page" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    
    it "creates a queue item that is associated with the correct video" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item that is associated with the current user" do
      sherlock = Fabricate(:user)
      set_current_user(sherlock)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(sherlock)
    end

    it "puts the new video at the last place in the queue" do
      sherlock = Fabricate(:user)
      set_current_user(sherlock)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: sherlock)
      arrow = Fabricate(:video)
      post :create, video_id: arrow.id
      arrow_queue_item = QueueItem.where(video_id: arrow.id, user_id: sherlock.id).first
      expect(arrow_queue_item.position).to eq(2)
    end

    it "does not add videos to the queue when they are already present in the queue" do
      sherlock = Fabricate(:user)
      set_current_user(sherlock)
      arrow = Fabricate(:video)
      Fabricate(:queue_item, video: arrow, user: sherlock)
      post :create, video_id: arrow.id
      expect(sherlock.queue_items.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 3 }
    end
  end

  describe "Post update queue" do
    it_behaves_like "requires sign in" do
      let(:action) { post :update_queue, queue_items: [{id: 1, position: 2}, {id: 2, position: 1}] }
    end

    context "with valid inputs" do
      let(:sherlock) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: sherlock, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: sherlock, position: 2, video: video) }

      before { set_current_user(sherlock) }
      
      it "redirects to the 'My Queue' page" do        
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(sherlock.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(sherlock.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs" do
      let(:sherlock) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: sherlock, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: sherlock, position: 2, video: video) }

      before { set_current_user(sherlock) }
      
      it "redirects to the 'My Queue' page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 1.5}, {id: queue_item2.id, position: 1}]
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 1}, {id: queue_item2.id, position: 2.2}]
        expect(queue_item1.reload.position).to eq(1)
      end

      it "does not change the queue items" do
        sherlock = Fabricate(:user)
        set_current_user(sherlock)
        watson = Fabricate(:user)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: sherlock, position: 1, video: video)
        queue_item2 = Fabricate(:queue_item, user: watson, position: 2, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 1}, {id: queue_item2.id, position: 2}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "redirects to the 'My Queue' page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      sherlock = Fabricate(:user)
      set_current_user(sherlock)
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      sherlock = Fabricate(:user)
      set_current_user(sherlock)
      queue_item1 = Fabricate(:queue_item, user: sherlock, position: 1)
      queue_item2 = Fabricate(:queue_item, user: sherlock, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 3 }
    end
  end
end
