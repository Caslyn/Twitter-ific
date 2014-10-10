class SessionsController < ApplicationController

	def new
	end

	def create
		
		unless params[:guest]
			user = User.find_by(email: params[:session][:email].downcase)
		end
		
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		elsif params[:guest] 
			user = User.find_by(email: params[:guest])
			redirect_to user_url user
		else
			# Create an error message and re-render the signin form
			flash.now[:error] = 'Invalid email/password combination' 
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end
