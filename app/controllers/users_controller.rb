class UsersController < ApplicationController

  def index
    @users = policy_scope(User).tagged_with(params['interests'])
  end

  def user_params
    params.require(:user).permit(:name, :tag_list, :avatar, :photos, :skill_list, :interest_list)
  end

  def tagged
    if params[:interest].present?
      @users = User.tagged_with(params[:interest])
      authorize @users
    else
      @users = policy_scope(User).order(created_at: :desc)
    end
  end
end
