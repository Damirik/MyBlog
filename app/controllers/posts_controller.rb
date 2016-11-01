class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @post = Post.new
    @blog = Blog.find_by(params[:id])
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @blog = Blog.find_by(params[:id])
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_blog_path(@blog.user, @blog),
        notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @blog = Blog.find_by(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_blog_path(@blog.user, @blog),
        notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_blogs_path(current_user),
      notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id, :blog_id)
    end
end
