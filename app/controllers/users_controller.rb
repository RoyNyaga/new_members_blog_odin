class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:edit, :update]

  def index
    @user = User.all
  end 

 def show
  @user = User.find(params[:id])
 end 

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome to Nyaga Andre Roy's App"
      redirect_to @user

    else
      render :new
    end 
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    # def logged_in_user
    #   unless logged_in?
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
end
