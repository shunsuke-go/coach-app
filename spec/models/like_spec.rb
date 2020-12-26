require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "#create" do
    context "likeを保存できる場合" do
     let(:like) { create(:like) }
      it "正常に保存できること" do
        expect(like).to be_valid  
      end
    end

    context "likeを保存できない場合" do 
      let(:like) { build(:like) }

      it "user_idが存在しないと保存できないこと" do 
        like.user_id = ""
        expect(like).to be_invalid  
      end

      it "article_idが存在しないと保存できないこと" do 
        like.article_id = ""
        expect(like).to be_invalid  
      end
    end

    context "一意性のテスト" do 
      let(:like) { create(:like) }
      it "article_idとuser_idの組み合わせは一意であること" do
        another_like = build(:like, user_id: like.user_id, article_id: like.article_id)
        expect(another_like).to be_invalid   
      end
    end
  end
end
