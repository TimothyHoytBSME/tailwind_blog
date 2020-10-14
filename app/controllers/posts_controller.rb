#Index and Post actions

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  respond_to :js, :json, :html
  
  def index
    @posts = Post.all
    
  end
  
  def show
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
  end
  
  def update   
    if(@post.update(post_params))
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy  
     @post.destroy
     redirect_to posts_path
  end
  
  def vote
      puts "MADE IT HERE!!!!!!!!!!!!!!!!!!!!!!!!"
      set_post
      if !current_user.liked? @post
        puts "REMOVING LIKE BY THIS USER"
        @post.liked_by current_user
        #render layout: false
      elsif current_user.liked? @post
        puts "LIKING BY THIS USER"
        @post.unliked_by current_user
        #render layout: false
      end
  end
  
  private
    def post_params
        params.require(:post).permit(:title, :body)
    end
    
    def set_post
      @post = Post.find(params[:id]) # lazy loading
    end
end
