require 'integration_test_helper'

class CourseTest < ActionDispatch::IntegrationTest

  should 'show course overview' do
    course1 = Factory.create(:course, :title => "Computergraphics course", :description => "ZEZE FLY")
    course2 = Factory.create(:course, :title => "singing", :description => "loud")

    visit "/courses"

    assert page.has_content?('Begegnungen')
    assert page.has_content?('Computergraphics course')
    assert page.has_content?('singing')
    assert page.has_content?('ZEZE FLY')
    assert page.has_content?('loud')
    assert !page.has_content?('lame')
  end

end
