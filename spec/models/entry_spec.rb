require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe '#create' do
    context 'entryが保存できる場合' do
      let(:entry) { create(:entry) }

      it '正常に保存できること' do
        expect(entry).to be_valid
      end
    end

    context 'entryが保存できない場合' do
      let(:entry) { build(:entry) }

      it 'user_idが存在しないと保存できないこと' do
        entry.user_id = ''
        expect(entry).to be_invalid
      end

      it 'room_idが存在しないと保存できないこと' do
        entry.room_id = ''
        expect(entry).to be_invalid
      end
    end

    context '一意性のテスト' do
      let(:entry) { create(:entry) }

      it 'user_idとroom_idの組み合わせは一意であること' do
        another_entry = build(:entry, user_id: entry.user_id, room_id: entry.room_id)
        expect(another_entry).to be_invalid
      end
    end
  end
end
