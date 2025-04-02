class PostsController < ApplicationController
  def index
    @posts = Post.preload(:user).default_order
  end

  def show
    @post = Post.find(params.expect(:id))
    @comments = @post.comments.preload(:user).default_order
  end
end
