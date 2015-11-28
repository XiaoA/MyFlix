require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :full_name }
  it { should validate_uniqueness_of :email }

  describe "#queued_video?" do
    it "returns true when the user has added the video to queue item list" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(User.last.queued_video?(video)).to eq(true)
    end
  end

  it "returns false when the user hasn't added the video to queue item list" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    expect(User.last.queued_video?(video)).to eq(false)
  end
end
