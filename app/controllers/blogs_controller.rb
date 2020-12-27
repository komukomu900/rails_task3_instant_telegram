class BlogsController < ApplicationController
  before_action :set_blogs, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user, only: [:edit, :update, :destroy]
  def index
    @blogs = Blog.all
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    elsif @blog.save
      CreateMailer.create_mail(@blog).deliver
      redirect_to blogs_path
    else
      render :new
    end
  end
  
  def confirm
    @blog = current_user.blogs.build(blog_params)
    @blog.id = params[:id]
    render :index if @blog.invalid?
  end

  def edit
  end

  def update
    @blog.update(blog_params)
    redirect_to blogs_path
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path
  end

  private
  def set_blogs
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def check_current_user
    user = User.find(current_user.id)
    if user.id != current_user.id
      redirect_to blogs_path, notice: "この操作はできません"
    end
  end
end