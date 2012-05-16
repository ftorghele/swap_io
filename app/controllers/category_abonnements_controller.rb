class CategoryAbonnementsController < ApplicationController
  require 'json'

  def find_categories
    #TODO Refactor to toggle_category_abonnements
    #CategoryAbonnement.toggle_category_abonnements current_user, params[:category]
    if signed_in?
      category = Category.find(params[:category])
      if category_abonnement = current_user.category_abonnements.find_by_category_id(category.id)
        category_abonnement.destroy
      else
        current_user.category_abonnements.create(:category => category )
      end
    end
    ##
    if signed_in?
      @courses = current_user.find_category_abonnements
    else
      categories_array = []
      categories = JSON.parse(cookies[:categories]).to_hash
      categories.each do |key, value| categories_array << value.to_i end
      @courses = Course.find_all_by_category_id(@categories)

    end

    if request.xhr?
      categories = {:k1 => "0",:k2 => "1", :k3 => "2"}

      cookies[:categories] = {
        :value => categories.to_json,
        :expires => 4.years.from_now
      }

      c = render_to_string :partial => "courses/course", :collection => @courses
      c = c.html_safe.gsub(/\n/, '').gsub(/\t/, '').gsub(/\r/, '')
      render :json => c
    else

      categories = {:k1 => "0"}
      cookies[:categories] = categories

      cookies[:categories] = {
        :value => categories.to_json,
        :expires => 4.years.from_now
      }

      redirect_to :courses
    end
  end
end
