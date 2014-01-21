class SessionsController < ApplicationController
  def new
    SecureRandom.urlsafe_base64
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end


  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
