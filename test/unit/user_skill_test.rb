require 'test_helper'

class UserSkillTest < ActiveSupport::TestCase

  should 'create user_skills for user' do
    assert_difference "UserSkill.count" do
      Factory.create(:user_skill)
    end
  end

  should 'validate user_skills correct' do
    assert_raise ActiveRecord::RecordInvalid do
      Factory.create(:user_skill, :user => nil)
    end
    assert_raise ActiveRecord::RecordInvalid do
      Factory.create(:user_skill, :title => nil)
    end
  end

end
