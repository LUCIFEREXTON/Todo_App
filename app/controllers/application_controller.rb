class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in
  @selected_list_id = nil
  def current_user
    User.find_by(id:session[:user_id]) if session[:user_id]
  end

  def logged_in
    current_user.present?
  end
end