module SessionsHelper

	#Logs in the given user
	def log_in(user)
		session[:user_id]=user.id
	end

	#Forget session
	def forget(user)
		user.forget
		cookies.delete(:user_id)		
		cookies.delete(:remember_token)
	end
	# Remembers a user in a persistent session.
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	#Log out the current user
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
	# Returns the user corresponding to the remember token cookie.
	def current_user
	  if (user_id = session[:user_id])
	    @current_user ||= User.find_by(id: user_id)
	  elsif (user_id = cookies.signed[:user_id])
	    user = User.find_by(id: user_id)
	    if user && user.authenticated?(cookies[:remember_token])
	      log_in user
	      @current_user = user
	    end
	  end
	end

	def correct_user?(user)
		current_user == user
	end

	def logged_in?
		!current_user.nil?
	end

	def store_location
		session[:forwading_url] = request.url if request.get?
	end

	def redirect_back_or(default)
		redirect_to(session[:forwading_url] || default)
		session.delete(:forwading_url)		
	end
end
