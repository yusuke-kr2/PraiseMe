class SignupController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to praises_path, notice: "登録完了！"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end
end
