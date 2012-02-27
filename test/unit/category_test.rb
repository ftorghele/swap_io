require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  should 'be able to create category' do
    category = Factory.create(:category)
    assert category.valid?
  end

  should 'not be valid without title' do
    assert_no_difference "Category.count" do
      category = Factory.build(:category, :title => nil)
      category.save
    end
  end

end
