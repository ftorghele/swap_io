class CategoryAbonnementsController < ApplicationController
  require 'json'

  def find_categories
    @category = Category.find(params[:category])

    if signed_in?
      current_user.toggle_category_abonnements @category
    end

    #### set cookies
    if cookies[:categories].present?
      temp_val = JSON.parse cookies[:categories]
      #Update the cookie value in temp_val
      if signed_in?
        temp_val[@category.title] = (current_user.category_abonnements.find_by_category_id(@category)) ? 0 : 1
        @courses = Course.set_user_courses current_user
      else
        puts temp_val
        temp_val[@category.title] = (temp_val[@category.title] == 1) ? 0 : 1
        @courses = Course.set_courses temp_val
        puts temp_val
      end
      #Write the updated temp_val to cookie
      cookies[:categories] = temp_val.to_json
    else
      #Done if user deletes cookie on Begegnung and press any menu button
      cookies[:categories] = Course.set_new_cookie JSON.parse(cookies[:categories])
      @courses = Course.all
    end

    if request.xhr?
      c = render_to_string :partial => "courses/course", :collection => @courses
      c = c.html_safe.gsub(/\n/, '').gsub(/\t/, '').gsub(/\r/, '')
      render :json => c
    else
      redirect_to :courses
    end
  end

end
