require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    
    context "userを保存できる場合" do
      let(:user) { build(:user) }      
      it "正常値の場合、保存できること" do
        expect(user).to be_valid  
      end
    
      it "パスワードが6文字以上なら保存できること" do
        user.password = "aaaaaa"
        user.password_confirmation = "aaaaaa"
        expect(user).to be_valid
      end

      it "名前が15文字以内なら保存できること" do
        user.name = "a" * 15
        expect(user).to be_valid 
      end

      it "メールアドレスが255文字以内なら登録できること" do 
        user.email = "aaaaa" + "@" + "a" * 245 + ".com" 
        expect(user).to be_valid  
      end
    end

    context "userを保存できない場合" do
      let(:user) { build(:user) }
      it "名前が空欄だと保存できないこと" do 
        user.name = ""
        expect(user).to be_invalid  
      end

      it "名前が16文字以上だと保存できないこと" do 
        user.name = "a" * 16
        expect(user).to be_invalid  
      end

      it "メールアドレスが空欄だと保存できないこと" do
        user.email = ""
        expect(user).to be_invalid  
      end

      it "メールアドレスが256文字以上だと登録できないこと" do
        user.email = "aaaaa" + "@" + "a" * 246 + ".com"
        expect(user).to be_invalid   
      end

      it "重複したメールアドレスは登録できないこと" do
        user.save
        another_user = build(
          :user,
          name: "田中",
          email: user.email,
          password: "tanaka",
          password_confirmation: "tanaka")
        expect(another_user).to be_invalid  
      end

      it "パスワードが空欄だと保存できないこと" do 
        user.password = ""
        user.password_confirmation = ""
        expect(user).to be_invalid  
      end

      it "パスワードが6文字以下だと保存できないこと" do 
        user.password = "a" * 5
        expect(user).to be_invalid  
      end

      it "パスワードとパスワード（確認）が違うと保存できないこと" do 
        user.password_confirmation = "a" * 6
        expect(user).to be_invalid
      end

      it "パスワード（確認）が空欄だと保存できないこと" do
        user.password_confirmation = ""
        expect(user).to be_invalid   
      end
    end
  end
end
