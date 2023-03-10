require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  # run before every test
  def setup
    @category = Category.new(name: "Sports")
  end

  # each test run parallel and in encapsulated manner
  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    @category1 = Category.new(name: "Sports")
    assert_not @category1.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too small" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end