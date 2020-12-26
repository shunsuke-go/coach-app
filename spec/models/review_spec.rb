require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#create' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    context '正常に保存できる場合' do
      let(:review) {
        create(
          :review,
          reviewer_id: user1.id,
          reviewed_id: user2.id
        )
      }

      it 'reviewが保存できること' do
        expect(review).to be_valid
      end

      it 'rateが5以下なら保存できること' do
        review.rate = 5
        expect(review).to be_valid
      end

      it 'rateが1以上なら保存できること' do
        review.rate = 1
        expect(review).to be_valid
      end
    end

    context '保存できない場合' do
      let(:review) {
        build(
          :review,
          reviewer_id: user1.id,
          reviewed_id: user2.id
        )
      }

      it 'contentが存在しないなら保存できないこと' do
        review.content = ''
        expect(review).to be_invalid
      end

      it 'contentが301文字以上だと保存できないこと' do
        review.content = 'a' * 301
        expect(review).to be_invalid
      end

      it 'reviewer_idが無いと保存できないこと' do
        review.reviewer_id = ''
        expect(review).to be_invalid
      end

      it 'reviewed_idが無いと保存できないこと' do
        review.reviewed_id = ''
        expect(review).to be_invalid
      end

      it 'rateが数字でないと保存できないこと' do
        review.rate = 'aaa'
        expect(review).to be_invalid
      end

      it 'rateが存在しないと保存できないこと' do
        review.rate = nil
        expect(review).to be_invalid
      end

      it 'rateが1より小さいと保存できないこと' do
        review.rate = 0
        expect(review).to be_invalid
      end

      it 'rateが5より大きいと保存できないこと' do
        review.rate = 6
        expect(review).to be_invalid
      end
    end
  end
end
