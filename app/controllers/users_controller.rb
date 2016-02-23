class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Welcome to the Chirp App!"
  		redirect_to users_path
  	else
  		render 'new'
  	end
  end

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
