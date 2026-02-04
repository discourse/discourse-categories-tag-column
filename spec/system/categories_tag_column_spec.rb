# frozen_string_literal: true

require_relative "page_objects/components/categories_tag_column"

RSpec.describe "Categories tag column" do
  fab!(:tag) { Fabricate(:tag, name: "javascript") }
  fab!(:tag2) { Fabricate(:tag, name: "ruby") }
  fab!(:topic) { Fabricate(:topic, tags: [tag, tag2]) }

  let!(:theme) { upload_theme_component }
  let(:tag_column) { PageObjects::Components::CategoriesTagColumn.new }

  before do
    SiteSetting.tagging_enabled = true
    SiteSetting.desktop_category_page_style = "categories_and_latest_topics"
  end

  it "displays tags with correct links" do
    visit("/categories")

    expect(tag_column).to be_visible
    expect(tag_column).to have_listed_tag(tag)
    expect(tag_column).to have_listed_tag(tag2)
  end
end
