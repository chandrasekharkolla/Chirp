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
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.first_name
    end
  end

  def location
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.first_name
    end
  end

  def show
  	@user = User.find(params[:id])
    @random_users = User.where.not(id: @user).order("RANDOM()")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :mobile_number, :email, :password, :password_confirmation, :location, :image)
  	end
end
