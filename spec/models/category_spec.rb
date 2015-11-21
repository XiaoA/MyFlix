require 'spec_helper'

describe Category do
  it {should have_many(:videos) }
  it {should validate_presence_of(:category_name) }

  describe "#recent_videos" do
    it "returns videos in reverse chronological order, by 'created_at' timestamp" do
      comedies = Category.create(category_name: "comedies")
      futurama = Video.create(title: "Futurama", description: "Space adventure", category: comedies, created_at: 1.day.ago)
      back_to_the_future = Video.create(title: "Back to the Future", description: "Time Travel adventure", category: comedies)
      expect(comedies.recent_videos).to eq([back_to_the_future, futurama])
    end

    it "returns all videos if there are less than six total videos" do
      comedies = Category.create(category_name: "comedies")
      futurama = Video.create(title: "Futurama", description: "Space adventure", category: comedies)
      back_to_the_future = Video.create(title: "Back to the Future", description: "Time Travel adventure", category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns six videos if there are more than six total videos" do
      comedies = Category.create(category_name: "comedies")
      7.times {Video.create(title: 'video', description: 'great video', category: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the six most recently videos" do
      comedies = Category.create(category_name: "comedies")
      6.times {Video.create(title: 'video', description: 'great video', category: comedies)}
      futurama = Video.create(title: "Futurama", description: "Space adventure", category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(futurama)
    end

    it "returns and empty array if the category does not have any videos" do
      comedies = Category.create(category_name: "comedies")
      expect(comedies.recent_videos).to eq([])
    end
  end
end
