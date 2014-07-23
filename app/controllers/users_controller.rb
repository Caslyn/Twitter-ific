class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  	def user_params
		# require the params hash to have a :user attribute 
		# permit the name, email, password & password confirmation
		# attributes (but no others)
		params.require(:user).permit(:name, :email, :password,
									 :password_confirmation)
	end

  def create
  	# user_params only to be used internally
  	@user = User.new(user_params) # Not the final implementation!
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to Caslyn's Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

	private :user_params
end
