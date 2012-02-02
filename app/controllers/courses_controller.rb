class CoursesController < ApplicationController

  before_filter :authenticate_user!

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
