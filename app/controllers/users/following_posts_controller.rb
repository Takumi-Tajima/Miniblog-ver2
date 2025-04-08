class Users::FollowingPostsController < Users::ApplicationController
  def show
    @posts = Post.where(user_id: current_user.following.pluck(:id))
  end
end
