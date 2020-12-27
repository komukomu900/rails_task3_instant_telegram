class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show, :favorite, :post_index]
  before_action :check_current_user, only: [:update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new, notice: "失敗しました"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit, notice: "失敗しました"
    end
  end

  def show
  end

  def post_index
    @blogs = @user.blogs
  end

  def favorite
    @blog = @user.blogs
    favorite = Favorite.where(user_id: current_user.id).pluck(:blog_id)
    @favorite_list = Blog.find(favorite)
  end

  def destroy
    @user.destroy
    redirect_to new_user_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end

  def check_current_user
    user = User.find(params[:id])
    if user.id != params[:id].to_i
      redirect_to new_user_path, notice: "この操作はできません"
    end
  end
end