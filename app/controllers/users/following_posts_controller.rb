class Users::FollowingPostsController < Users::ApplicationController
  def show
    @posts = Post.joins('INNER JOIN follows ON posts.user_id = follows.followed_id')
                 .where(follows: { follower_id: current_user.id })
                 .default_order
  end
end
