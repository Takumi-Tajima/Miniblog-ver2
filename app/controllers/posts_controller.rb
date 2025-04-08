class PostsController < ApplicationController
  def index
    @posts = Post.preload(:user).default_order
  end

  def show
    @post = Post.find(params.expect(:id))
    @comments = @post.comments.preload(:user).default_order
    @comment = current_user.comments.build if user_signed_in?
  end
end
