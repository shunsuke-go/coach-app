class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :create]

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.valid?
      @profile.save
      flash[:success] = '登録に成功しました'
      redirect_to user_path(current_user)
    else

      render 'new'

    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)

      flash[:success] = 'プロフィールを更新しました。'
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:content, :age, :address)
    end
end
