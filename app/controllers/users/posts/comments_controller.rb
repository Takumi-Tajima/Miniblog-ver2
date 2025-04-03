class Users::Posts::CommentsController < Users::ApplicationController
  def create
    post = Post.find(params.expect(:post_id))
    comment = post.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to post_path(post), notice: t('controllers.common.created', model: 'コメント')
    else
      redirect_to post_path(post), alert: t('controllers.common.not_created', model: 'コメント'), status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params.expect(:post_id))
    comment = post.comments.find(params.expect(:id))

    comment.destroy!
    redirect_to post_path(post), notice: t('controllers.common.destroyed', model: 'コメント'), status: :see_other
  end

  private

  def comment_params
    params.expect(comment: [:content])
  end
end
