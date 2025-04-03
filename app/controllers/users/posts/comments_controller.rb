class Users::Posts::CommentsController < Users::ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    comment = @post.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to post_path(@post), notice: t('controllers.common.created', model: 'コメント')
    else
      redirect_to post_path(@post), alert: t('controllers.common.not_created', model: 'コメント'), status: :unprocessable_entity
    end
  end

  def destroy
    comment = current_user.comments.find_by!(id: params.expect(:id), post_id: @post.id)

    comment.destroy!
    redirect_to post_path(@post), notice: t('controllers.common.destroyed', model: 'コメント'), status: :see_other
  end

  private

  def set_post
    @post = Post.find(params.expect(:post_id))
  end

  def comment_params
    params.expect(comment: [:content])
  end
end
