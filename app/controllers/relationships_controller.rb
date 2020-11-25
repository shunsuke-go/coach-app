class RelationshipsController < ApplicationController
before_action :logged_in_user

def create
  other_user = User.find_by(id: params[:followed_id])
  current_user.follow(other_user)
  current_user.create_follow_notification(current_user, other_user)

  redirect_to other_user
end


# params[:id]　にはログイン中ユーザがフォローしている@userのidが入っている
# relationshipsテーブルから
def destroy
  other_user = Relationship.find_by(id: params[:id]).followed
  current_user.unfollow(other_user)
  redirect_to other_user
end



end
