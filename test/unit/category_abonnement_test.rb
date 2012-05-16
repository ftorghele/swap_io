require 'test_helper'

class CategoryAbonnementTest < ActiveSupport::TestCase

  should 'create category_abonnement for user' do
    assert_difference "CategoryAbonnement.count" do
      Factory.create(:category_abonnement)
    end
  end

  should 'delete category_abonnement correctly' do
    category_abonnement = Factory.create(:category_abonnement)
    assert_difference "CategoryAbonnement.count", -1 do
      category_abonnement.delete
    end
  end

  should 'be able to create category_abonnement as user' do
    user = Factory.create(:user)
    category = Factory.create(:category)
    category_abonnement = user.category_abonnements.create(:category => category)
    assert_equal category_abonnement.user_id, user.id
    assert_equal user.category_abonnements, [category_abonnement]
  end

  should 'be able to have many categories abonnated' do
    user = Factory.create(:user)
    category1 = Factory.create(:category)
    category2 = Factory.create(:category)
    category3 = Factory.create(:category)
    assert_difference "CategoryAbonnement.count", 3 do
      user.category_abonnements.create(:category => category1)
      user.category_abonnements.create(:category => category2)
      user.category_abonnements.create(:category => category3)
    end
  end

  should 'be able to find courses from abonnated categories' do
    user = Factory.create(:user)
    category1 = Factory.create(:category)
    category2 = Factory.create(:category)
    category3 = Factory.create(:category)
    course1 = Factory.create(:course, :category => category1)
    course2 = Factory.create(:course, :category => category2)
    course3 = Factory.create(:course, :category => category3)
    user.category_abonnements.create(:category => category1)
    user.category_abonnements.create(:category => category3)
    puts user.find_category_abonnements
    assert_equal user.find_category_abonnements.length, 2
    assert_equal user.find_category_abonnements.last.category_id , category3.id
  end
end
