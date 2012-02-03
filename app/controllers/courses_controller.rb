class CoursesController < ApplicationController

  def new
  end

  def create
  end

  def index
    @courses = Course.find(:all)
  end

  def show
    @course = Course.find(params[:id])
  end

  def destroy
  end

end
