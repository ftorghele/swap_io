class PagesController < ApplicationController
  def overview
    redirect_to :welcome unless signed_in? and return

  end

  def welcome
    @subscriber = Subscriber.new
    render :layout => 'welcome'
  end
end
