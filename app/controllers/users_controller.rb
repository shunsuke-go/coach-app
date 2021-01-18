class UsersController < ApplicationController
  include UsersHelper
  before_action :logged_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :check_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @feed_items = @user.articles.with_rich_text_content.includes(
      :user, :liked_users, :likes, :comments, :taggings, :tags
    ).paginate(page: params[:page], per_page: 5)
    if logged_in?
      @room = @user.users_room(current_user)
      if @room.blank?
        @room = Room.new
        @entry = Entry.new
      end
    end

    @profile = Profile.find_by(user_id: params[:id])
    @review = Review.new
    @reviews = @user.passive_reviews
    @ave_rate = @user.ave_rate.round(1) unless @user.ave_rate.nil?
  end

  def create
    @user = User.new(user_params)
    @user.toggle(:coach) if params[:user][:coach] == '1'
    if @user.save
      log_in(@user)
      redirect_to new_user_profile_path(@user)
      flash[:notice] = 'プロフィールも作成しましょう！'
    else
      render 'new'

    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.toggle(:coach) if params[:user][:coach] == '1'
    @user.remove_avatar! if params[:user][:avatar_delete] == '1'
    if @user.update!(user_params)
      flash[:success] = '更新に成功しました！'
      redirect_to user_url(@user)

    else
      flash[:danger] = '更新に失敗しました'
      render 'edit'
    end
  end

  def index
    @users = User.includes(:profile).paginate(page: params[:page], per_page: 5)
    @coaches = User.where('coach = true').includes(:profile).paginate(page: params[:page], per_page: 5)
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = '削除に成功しました'
    redirect_to user_url
  end

  def following
    @title = 'フォロー'
    @user = User.find_by(id: params[:id])
    @users = @user.following.paginate(page: params[:page])
    if logged_in?
      @room = Room.find_by_sql("SELECT * FROM rooms WHERE id IN
        (SELECT room_id FROM entries WHERE user_id = #{@user.id} &&
        room_id IN (SELECT room_id FROM entries WHERE user_id = #{current_user.id}))")
      if @room[0].nil?
        @room = Room.new
        @entry = Entry.new
      end
    end

    @profile = Profile.find_by(user_id: params[:id])
    @review = Review.new
    @reviews = @user.passive_reviews
    @ave_rate = @user.ave_rate.round(1) unless @user.ave_rate.nil?

    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user = User.find_by(id: params[:id])
    @users = @user.followers.paginate(page: params[:page])
    if logged_in?
      @room = Room.find_by_sql("SELECT * FROM rooms WHERE id IN
        (SELECT room_id FROM entries WHERE user_id = #{@user.id} &&
        room_id IN (SELECT room_id FROM entries WHERE user_id = #{current_user.id}))")
      if @room[0].nil?
        @room = Room.new
        @entry = Entry.new
      end
    end

    @profile = Profile.find_by(user_id: params[:id])
    @review = Review.new
    @reviews = @user.passive_reviews
    @ave_rate = @user.ave_rate.round(1) unless @user.ave_rate.nil?

    render 'show_follow'
  end

  def guest_login
    unless logged_in?
      guest_user = User.find_by(email: 'guest@guest.com')
      log_in(guest_user)
      flash[:notice] = 'ゲストユーザーとしてログインしました'
    end
    flash[:notice] = 'すでにログインしています'
    redirect_to root_path
  end

  private

  # Strong Parameter
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

  # 別のユーザーページを編集するのを防ぐ
    def correct_user
      @user = User.find_by(id: params[:id])
      if @user.nil?
        flash[:danger] = '無効な操作です'
      end
      redirect_to root_url unless current_user?(@user)
    end

  # 管理者かどうか確認
    def check_admin
      unless current_user.admin?
        falsh[:danger] = '管理者のみ行える操作です'
        redirect_to root_url
      end
    end
end
