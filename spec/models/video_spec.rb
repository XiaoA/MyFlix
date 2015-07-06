require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Monk", description: "A funny drama about an ODC detective")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    dramas = Category.create(category_name: "dramas")
    monk = Video.create(title: "monk", description: "a great detective show", category: dramas)
    expect(monk.category).to eq(dramas)
  end

  it "does not save a video without a title" do
    video = Video.create(description: "A great show!")
    expect(Video.count).to eq(0)
  end

  it "does not save a video without a description" do
    video = Video.create(title: "South Park")
    expect(Video.count).to eq(0)
  end

end
