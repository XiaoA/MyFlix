require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders video in the queue" do

    dramas = Fabricate(:category, category_name: "dramas")
    arrow = Fabricate(:video, title: "Arrow", category: dramas)
    chuck = Fabricate(:video, title: "Chuck", category: dramas)
    monk = Fabricate(:video, title: "Monk", category: dramas)

    sign_in
    
    add_video_to_queue(arrow)
    expect_video_to_be_in_queue(arrow)

    visit video_path(arrow)
    expect_link_not_to_be_seen("+ My Queue")
    
    add_video_to_queue(chuck)
    add_video_to_queue(monk)
    
    set_video_position(arrow, 3)
    set_video_position(chuck, 1)
    set_video_position(monk, 2)

    update_queue
    
    expect_video_position(chuck, 1)
    expect_video_position(monk, 2)
    expect_video_position(arrow, 3)
  end
  

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click 
    click_link "+ My Queue"
  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content(video.title)      
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end
  
  def update_queue
    click_button "Update Instant Queue"
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).not_to have_content("+ My Queue")  
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)    
  end
end

