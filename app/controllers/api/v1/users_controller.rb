module Api::V1
  class UsersController < ApplicationController
    def index
      @users = User.where('coach != true').includes(:profile).paginate(page: params[:page], per_page: 5)
      @coaches = User.where('coach = true').includes(:profile).paginate(page: params[:page], per_page: 5)
      render json: {
        users: @users,
        coaches: @coaches
      }
    end

    def create
      @user = User.new(user_params)

      if @user.save
        log_in(@user)
        render json: { user: @user }
      else
        render json: { status: 500 }
      end
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
      @articles_count = @user.articles.all.count
    end

    def guest_login
      if logged_in?
        render json: 'すでにログインしています'
      else
        guest_user = User.find_by(email: 'guest@guest.com')
        log_in(guest_user)
        remember(guest_user)
        render json: {
          logged_in: true,
          user: guest_user,
          liked_articles: guest_user.liked_articles.with_rich_text_content.includes(
            :user, :liked_users, :likes, :comments, :taggings, :tags
          )
        }
      end
    end

    def all
      @users = User.all
      render json: { users: @users }
    end

    private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
      end
  end
end
