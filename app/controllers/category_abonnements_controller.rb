class CategoryAbonnementsController < ApplicationController
  require 'json'

  def find_categories
    @category = Category.find(params[:category])
    controller_type = params[:controller_type]
    comes_from_courses = (controller_type == 'courses')

    if signed_in?
      current_user.toggle_category_abonnements @category
    end

    #### set cookies
    if cookies[:categories].present?
      temp_val = JSON.parse cookies[:categories]
      #Update the cookie value in temp_val
      if signed_in?
        temp_val[@category.title] = (current_user.category_abonnements.find_by_category_id(@category)) ? 0 : 1
        if comes_from_courses
          @courses = Course.set_user_courses current_user
        else
          @course_requests = CourseRequest.set_user_courses current_user
        end
      else
        temp_val[@category.title] = (temp_val[@category.title].to_i == 1) ? 0 : 1
        if controller_type == 'courses'
          @courses = Course.set_courses temp_val
        else
          @course_requests = CourseRequest.set_courses temp_val
        end
      end
      #Write the updated temp_val to cookie
      temp_val = temp_val.to_hash
      cookies[:categories] = temp_val.to_json
    else
      #Done if user deletes cookie on Begegnung and press any menu button
      cookies[:categories] = CourseRequest.set_new_cookie
      (comes_from_courses) ? @courses = Course.all : @course_requests = CourseRequest.all
    end
    if request.xhr?
      if comes_from_courses
        c = render_to_string :partial => "courses/course", :collection => @courses
      else
        c = render_to_string :partial => "course_requests/course_request", :collection => @course_requests
      end
      c = c.html_safe.gsub(/\n/, '').gsub(/\t/, '').gsub(/\r/, '')
      render :json => c
    else
      if comes_from_courses
        redirect_to 'courses'
      else
        redirect_to 'course_requests'
      end
    end
  end

end
