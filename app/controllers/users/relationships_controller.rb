class Users::RelationshipsController < Users::ApplicationController
  before_action :set_user, only: %i[create destroy]

  def create
    if current_user.follow(@user)
      redirect_to user_path(@user), notice: t('controllers.relationships.created', model: @user.name)
    else
      redirect_to user_path(@user), notice: t('controllers.relationships.failed.created', model: @user.name), status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.unfollow(@user)
      redirect_to user_path(@user), notice: t('controllers.relationships.destroyed', model: @user.name), status: :see_other
    else
      redirect_to user_path(@user), notice: t('controllers.relationships.failed.destroyed', model: @user.name), status: :see_other
    end
  end

  private

  def set_user
    @user = User.find_by(id: params.expect(:id))
  end
end
