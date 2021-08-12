require 'rails_helper'

RSpec.describe Itemcomment, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @itemcomment = FactoryBot.build(:itemcomment, user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  describe 'コメント投稿機能' do
    context 'コメント投稿ができるとき' do
      it 'textが存在すれば出品できる' do
        expect(@itemcomment).to be_valid
      end
    end
    context 'コメント投稿ができないとき' do
      it 'テキストが空では登録できない' do
        @itemcomment.text = ''
        @itemcomment.valid?
        expect(@itemcomment.errors.full_messages).to include 'テキストを入力してください'
      end
      it 'user_idが空では購入できない' do
        @itemcomment.user_id = nil
        @itemcomment.valid?
        expect(@itemcomment.errors.full_messages).to include 'Userを入力してください'
      end
      it 'item_idが空では購入できない' do
        @itemcomment.item_id = nil
        @itemcomment.valid?
        expect(@itemcomment.errors.full_messages).to include 'Itemを入力してください'
      end
    end
  end
end
