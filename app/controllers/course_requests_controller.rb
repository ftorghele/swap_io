class CourseRequestsController < ApplicationController
  def index
    @course_requests = CourseRequest.all
  end
end
