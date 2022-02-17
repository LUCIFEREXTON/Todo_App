class SessionsController < ApplicationController
  before_action :allowed, except: [:logout]

  def signin
  end

  def signup
    @user = User.new
  end

  def logout
    session[:user_id] = nil
    redirect_to signin_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @list = List.new(name: @user.name, user_id: @user.id)
      if @list.save
        session[:user_id] = @user.id
        flash[:msg] = 'User Registered Successfully'
        redirect_to "/#{@selected_list_id}"
      else
        @user.destroy
        flash[:error] = 'User Not Registered'
        redirect_to signup_path
      end
    else
      flash[:error] = 'User Not Registered'
      redirect_to signup_path
    end
  end

  def verify
    name, password = params[:name], params[:password]
    user = User.find_by(name: name)
    if user.present? && user.authenticate(password)
      session[:user_id] = user.id
      flash[:msg] = 'Logged In'
      redirect_to "/#{@selected_list_id}"
    else
      flash[:error] = 'This combination of username and password is invalid'
      redirect_to signin_path
    end
  end

  private

  def allowed
    redirect_to root_path if logged_in
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end