class PostsController < ApplicationController
  def index
    @posts = Post.default_order
  end
end
