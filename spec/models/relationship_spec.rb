require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe '#create' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    context "正常に保存できる場合" do 
      let(:relationship) { create(
        :relationship,
        follower_id: user1.id, 
        followed_id: user2.id
      ) }

      it "relationshipを登録できること" do
        expect(relationship).to be_valid 
      end
    end

    context "保存できない場合" do 
      let(:relationship) { build(
        :relationship,
        follower_id: user1.id, 
        followed_id: user2.id
      ) }

      it "follower_idが存在しないと保存できないこと" do
        relationship.follower_id = ""
        expect(relationship).to be_invalid  
      end

      it "followed_idが存在しないと保存できないこと" do
        relationship.followed_id = ""
        expect(relationship).to be_invalid   
      end
    end

    context "一意性のテスト" do 
      let(:relationship) { create(
        :relationship,
        follower_id: user1.id, 
        followed_id: user2.id
      ) }

      it "followed_idとfollower_idの組み合わせは一意であること" do 
        another_relationship = build(
          :relationship,
          follower_id: relationship.follower_id,
          followed_id: relationship.followed_id
        )
        expect(another_relationship).to be_invalid  
      end
    end
  end
end
