class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :index, :show]
	before_action :correct_user, only: [:edit, :update]

	def index
		@user = User.find(current_user.id)
		@users = User.all
		@book_new = Book.new
	end

	def show
		@user = User.find(params[:id])
		@book_new = Book.new
		@books = @user.books.all
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to user_path(@user), notice: "You have updated user successfully."
		else
		   render 'edit'
		end
	end

	def following
    # @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.all
    render 'show_follow_users'
  end

  def followers
    # @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.all
    render 'show_follower_users'
  end

	private
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
	def correct_user
      @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
end
end
