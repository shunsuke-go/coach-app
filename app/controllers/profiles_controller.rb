class ProfilesController < ApplicationController
  
  def new
    @profile = current_user.build_profile
    render 'profile_form'
    
    
  end


  def create 
    @profile = current_user.build_profile(profile_params)

    if @profile.valid?
      @profile.save
      flash[:success] = "登録に成功しました"
      redirect_to users_path(current_user)
    else
      
      render 'profile_form'

    end

  end


  def update
  end

  private
    def profile_params
      params.require(:profile).permit(:content,:age,:address) 
    end


end
