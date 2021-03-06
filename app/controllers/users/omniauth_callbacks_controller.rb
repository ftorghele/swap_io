class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:info] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook", :name => @user.first_name
      sign_in_and_redirect @user, :event => :authentication
    else
      render :template => "users/complete_registration", :locals => {:user => @user}
    end
  end

end