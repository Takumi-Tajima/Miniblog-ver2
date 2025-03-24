class Users::PostsController < Users::ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: t('controllers.common.created', model: 'ポスト')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.expect(post: [:content])
  end
end
