require 'test_helper'

class UserSkillsTest < ActiveSupport::TestCase

  should 'create user_skills for user' do
    assert_difference "UserSkills.count" do
      Factory.create(:user_skills)
    end
  end

  should 'validate user_skills correct' do
    assert_raise ActiveRecord::RecordInvalid do
      Factory.create(:user_skills, :user => nil)
    end
    assert_raise ActiveRecord::RecordInvalid do
      Factory.create(:user_skills, :title => nil)
    end
  end

end
