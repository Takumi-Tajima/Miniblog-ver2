class Users::Posts::LikesController < Users::ApplicationController
  def index
    post = Post.find(params.expect(:post_id))
    @users = post.liked_users.default_order
  end

  def create
    current_user.likes.create!(post_id: params.expect(:post_id))
    redirect_to request.referer || root_path, notice: t('controllers.likes.created')
  end

  def destroy
    current_user.likes.find(params.expect(:id)).destroy!
    redirect_to request.referer || root_path, notice: t('controllers.likes.destroyed')
  end
end
