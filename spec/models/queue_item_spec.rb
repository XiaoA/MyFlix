require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer}

  describe "@video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "Monk")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Monk")
    end

    describe "@rating" do
      it "returns the user's rating when a review is present" do
        user = Fabricate(:user)
        video = Fabricate(:video)
        review = Fabricate(:review, user: user, video: video, rating: 4)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        expect(queue_item.rating).to eq(4)
      end

      it "returns nil when no review is present" do
        user = Fabricate(:user)
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        expect(queue_item.rating).to be(nil)
      end
    end
  end

  describe "#category_name" do
    it "returns the name of a video category" do
      category = Fabricate(:category, category_name: "action")
      video = Fabricate(:video, category: category) 
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("action")
    end

    describe "#category" do
      it "returns the category of the video" do
      category = Fabricate(:category, category_name: "action")
      video = Fabricate(:video, category: category) 
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
      end
    end
  end
end
