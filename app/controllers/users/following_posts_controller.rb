class Users::FollowingPostsController < Users::ApplicationController
  def show
    @posts = Post.where(user_id: current_user.following.pluck(:id)).preload(:user).default_order
  end
end
