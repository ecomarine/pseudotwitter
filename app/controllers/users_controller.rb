class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:edit, :update] #это ограничения в квадратной скобке
  before_action :correct_user, only: [:edit, :update] #человек не может редактировать и обновлять 
  before_action :admin_user,     only: :destroy #только админ может удалять
  
  def new
    @user = User.new
  end
  
    def create 
    @user = User.new(user_params) 
      
        if @user.save
          sign_in @user
          flash[:success] = "Вы успешно зарегистрировались!"
          redirect_to @user
        else
         render 'new'
        end
      end
      
      def show
        @user = User.find(params[:id])
        @microposts = @user.microposts.paginate(page: params[:page])
      end
      
      
      def index
      @users = User.paginate(page: params[:page])
      end
      
      def edit
        @user = User.find(params[:id])
      end
      
      def update
        @user = User.find(params[:id])
       if @user.update_attributes(user_params)
        flash[:success] = "Вы успешно обновили информацию!"
        redirect_to @user
        else
          render 'edit'
        end
        end
      
      def destroy
      User.find(params[:id]).destroy
      flash[:success] = "Пользователь удален."
      redirect_to users_url
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

      
      
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
     # Before filters

    
    # def signed_in_user
    #   if not signed_in?
    #     redirect_to signin_path, notice: "Пожалуйста сначала войдите." 
    # end
  end
  
   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
   def edit
    @user = User.find(params[:id])
  end
  
  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
