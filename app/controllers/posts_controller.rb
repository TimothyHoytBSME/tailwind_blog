#Index and Post actions

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  
  def index
    @posts = Post.all
  end
  
  def show
    @post= Post.find(params[:id])
  end
  
  def new   
    @title = 'New Post';
    @post = Post.new
  end
  
  def create
    
    @post = Post.new(post_params.merge(user_id: current_user.id))
    @post.user_id = current_user.id
    if(@post.save)
      redirect_to @post
    else
      
      render :new
      
    end   
  end
  
  def edit
    @title = 'Edit Post';
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    if(@post.update(post_params))
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
     @post = Post.find(params[:id])
     #@post.comments.each do |comment|
     #   comment.destroy
     #end 
     @post.destroy
     redirect_to posts_path
  end
  
  private
    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end
end
