require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe '#create' do
    context '正常に保存できる場合' do
      let(:profile) { create(:profile) }

      it 'profileが保存できること' do
        expect(profile).to be_valid
      end

      it 'ageが存在しなくても保存できること' do
        profile.age = nil
        expect(profile).to be_valid
      end

      it 'addressが存在しなくても保存できること' do
        profile.address = ''
        expect(profile).to be_valid
      end

      it 'contentが存在しなくても保存できること' do
        profile.content = ''
        expect(profile).to be_valid
      end
    end

    context '保存できない場合' do
      let(:profile) { create(:profile) }

      it 'user_idが存在しないと保存できないこと' do
        profile.user_id = ''
        expect(profile).to be_invalid
      end

      it 'ageが数字でないと保存できないこと' do
        profile.age = 'a'
        expect(profile).to be_invalid
      end

      it 'contentが1001文字以上だと保存できないこと' do
        profile.content = 'a' * 1001
        expect(profile).to be_invalid
      end

      it 'addressが11文字以上だと保存できないこと' do
        profile.address = 'a' * 11
        expect(profile).to be_invalid
      end
    end
  end
end
