class CoursesController < ApplicationController

  def new
  end

  def create
  end

  def index
    @courses = Course.get_courses
  end

  def show
  end

  def destroy
  end

end
