class UsersController < ApplicationController
    
    def index
      @users = User.all
    end
  
    def show
      @user = User.find(params[:id])
      @users = User.all
    end
   
    def new
      @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
        redirect_to root_path, notice: 'ユーザー登録が完了しました！'
        else
            render 'new'
        end
    end

def show
  @user = User.find(params[:id])
end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end