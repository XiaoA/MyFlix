require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(category_name: "comedies")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(category_name: "comedies")
    south_park = Video.create(title: "South Park", description: "A funny animated comedy about some michievous boys in Colorado.", category: comedies)
    futurama = Video.create(title: "Futurama", description: "A funny animated comedy about a guy who is thawed out in the future.", category: comedies)
    expect(comedies.videos).to eq([futurama, south_park])
  end
end
