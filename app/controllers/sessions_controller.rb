class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back, #{params[:username]}"
    else
      redirect_to signin_path, notice: "Wrong username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  def create_oauth
  end
end
