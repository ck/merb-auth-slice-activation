class MerbAuthSliceActivation::Activations <  MerbAuthSliceActivation::Application

  after :redirect_after_activation

  # Activate a user from the submitted activation code.
  #
  # ==== Returns
  # String:: Empty string.
  def activate
    session.user = Merb::Authentication.user_class.find_with_activation_code(params[:activation_code])
    raise NotFound if session.user.nil?
    if session.authenticated? && !session.user.activated?
      session.user.activate
    end
    ""
  end

  private

  def redirect_after_activation
    redirect "/", :message => {:notice => "Activation Successful"}
  end

end # MerbAuthSliceActivation::Activations
