class PostsController < ApplicationController
  def index
    @pots = Post.default_order
  end
end
