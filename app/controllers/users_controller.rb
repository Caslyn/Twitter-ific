class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	if signed_in? 
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def user_params
	# require the params hash to have a :user attribute 
	# permit the name, email, password & password confirmation
	# attributes (but no others)
	params.require(:user).permit(:name, :email, :password,
								 :password_confirmation)
end

  def create

    if :guest 
      user = User.new(name: "Guest", email: "guest@example.com",
        password: "guest", password_confirmation: "guest")
    else
      user = User.new(user_params)
    end

  	if signed_in?
      redirect_to root_path
    elsif @user.save 
      sign_in @user
  		flash[:success] = "Welcome to Caslyn's Twitter App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
      delete_user = User.find(params[:id])
      unless current_user == delete_user && current_user.admin?
        delete_user.destroy
        flash[:success] = "User deleted."
        redirect_to users_url
      end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

	private :user_params, :signed_in_user, :correct_user, :admin_user
end
