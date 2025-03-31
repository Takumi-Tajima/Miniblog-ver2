class Users::RelationshipsController < Users::ApplicationController
  def create
    user = User.find_by(id: params.expect(:user_id))
    if user && current_user.follow(user)
      redirect_to request.referer || root_path, notice: t('controllers.relationships.created', model: "#{user.name}さん")
    else
      redirect_to request.referer || root_path, notice: t('controllers.relationships.failed.created', model: "#{user.name}さん"), status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.unfollow(params.expect(:id))
      redirect_to request.referer || root_path, notice: t('controllers.relationships.destroyed'), status: :see_other
    else
      redirect_to request.referer || root_path, notice: t('controllers.relationships.failed.destroyed'), status: :see_other
    end
  end
end
