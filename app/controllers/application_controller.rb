class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	helper_method :current_user
	helper_method :logged_in?

	private

	def login_user!
		if @user
			@user.reset_session_token!
			session[:session_token] = @user.session_token
			redirect_to '#/images'
		else
			flash[:errors] = ["Invalid username or password"]
			redirect_to new_session_url
		end
	end

	def logout_user!
		current_user.reset_session_token!
		session[:session_token] = nil
		redirect_to new_session_url
	end

	def current_user
		@current_user ||= User.find_by(session_token: session[:session_token])
	end

	def logged_in?
		!!current_user
	end

	def require_logged_in
		redirect_to new_session_url unless logged_in?
	end
end
