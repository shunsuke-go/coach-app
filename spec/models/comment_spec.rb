require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    let(:comment) { FactoryBot.build(:comment) }

    context 'コメントを保存できる場合' do
      it '正しく保存できること' do
        example_comment = FactoryBot.create(:comment)
        expect(example_comment).to be_valid
      end
    end

    context 'コメントを保存できない場合' do
      it 'コメントが空欄だと保存できない' do
        comment.content = ''
        expect(comment).to be_invalid
      end

      it 'コメントが101文字以上だと保存できない' do
        comment.content = 'a' * 101
        expect(comment).to be_invalid
      end
    end
  end
end
