class Users::Posts::LikesController < Users::ApplicationController
  def create
    current_user.likes.create!(post_id: params[:post_id])
    redirect_to request.referer || root_path, notice: t('controllers.likes.created')
  end

  def destroy
    current_user.likes.find_by!(post_id: params[:post_id]).destroy!
    redirect_to request.referer || root_path, notice: t('controllers.likes.destroyed')
  end
end
