class Users::PostsController < Users::ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: t('controllers.common.created', model: 'ポスト')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: t('controllers.common.updated', model: 'ポスト'), status: :see_other
    else
      render :edit, status: :unprocessable
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: t('controllers.common.destroyed', model: 'ポスト'), status: :see_other
  end

  private

  def post_params
    params.expect(post: [:content])
  end

  def set_post
    @post = current_user.posts.find(params.expect(:id))
  end
end
