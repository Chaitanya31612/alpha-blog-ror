require 'rails_helper'


RSpec.describe Category, type: :model do
  context "validation tests" do
    let(:category) {Category.new(name: "sports")}

    it "Category should be valid" do
      expect(category).to be_valid
    end

    it "name should be present" do
      category.name = " "
      expect(category).not_to be_valid
    end

    it "name should be unique" do
      expect(category.save).to be_truthy

      category2 = Category.new(name: "sports")
      expect(category2).not_to be_valid
    end

    it "name should not be too long" do
      category.name = "a" * 26
      expect(category).not_to be_valid
    end

    it "name should not be too short" do
      category.name = "aa"
      expect(category).not_to be_valid
    end
  end
end