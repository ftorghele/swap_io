class PagesController < ApplicationController
  def overview
    render :home unless signed_in? and return



  end
end
