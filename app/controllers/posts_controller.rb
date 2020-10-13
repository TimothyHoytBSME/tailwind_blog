#Index and Post actions

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @posts = Post.all
  end
  
  def show
    #@post= Post.find(params[:id])  #lazy loading
    @post = Post.includes(:comments).find(params[:id]) #eager loading
    #puts "Is Eager Loaded?"
    #puts @post.association(:comments).loaded? #verify eager load
  end 
  
  def new   
    @title = 'New Post';
    @post = Post.new
  end
  
  def create    
    @post = Post.new(post_params.merge(user_id: current_user.id)) #new post with added field
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
     @post.destroy
     redirect_to posts_path
  end
  
  private
    def post_params
        params.require(:post).permit(:title, :body)
    end
end
