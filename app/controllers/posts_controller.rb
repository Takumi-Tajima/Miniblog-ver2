class PostsController < ApplicationController
  def index
    @posts = Post.preload(:user).default_order
  end
end
