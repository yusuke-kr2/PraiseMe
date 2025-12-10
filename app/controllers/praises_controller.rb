class PraisesController < ApplicationController
  before_action :set_user

  def index
    @praises = Praise.includes(:user).order(created_at: :asc)
    @praise = Praise.new
  end

  def create
    @praise = @user.praises.build(praise_params)
    if @praise.save
      redirect_to praises_path, notice: "褒め声を投稿しました！"
    else
      render :index
    end
  end

  def destroy
    @praise = @user.praises.find(params[:id])
    @praise.destroy

    redirect_to praises_path, notice: "投稿を削除しました"
  end

  
  private

  def praise_params
    params.require(:praise).permit(:audio)
  end

  # 仮でセッションに保存しているユーザーを取得
  def set_user
    @user = User.find(session[:user_id])
  end
end