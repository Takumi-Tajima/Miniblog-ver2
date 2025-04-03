class Users::Posts::CommentsController < Users::ApplicationController
  before_action :set_post, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

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
  end

  private

  def set_post
    @post = Post.find(params.expect(:post_id))
  end

  def set_comment
    @comment = @post.comments.find(params.expect(:id))
  end

  def comment_params
    params.expect(comment: [:content])
  end
end
