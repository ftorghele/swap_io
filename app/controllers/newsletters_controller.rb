class NewslettersController < ApplicationController

  def update
    Newsletter.spread params[:newsletter_id]
  end

end
