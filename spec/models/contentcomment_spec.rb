require 'rails_helper'

RSpec.describe Contentcomment, type: :model do
  before do
    user = FactoryBot.create(:user)
    content = FactoryBot.create(:content)
    @contentcomment = FactoryBot.build(:contentcomment, user_id: user.id, content_id: content.id)
    sleep(0.1)
  end

  describe 'コメント投稿機能' do
    context 'コメント投稿ができるとき' do
      it 'textが存在すれば出品できる' do
        expect(@contentcomment).to be_valid
      end
    end
    context 'コメント投稿ができないとき' do
      it 'テキストが空では登録できない' do
        @contentcomment.text = ''
        @contentcomment.valid?
        expect(@contentcomment.errors.full_messages).to include 'テキストを入力してください'
      end
      it 'user_idが空では購入できない' do
        @contentcomment.user_id = nil
        @contentcomment.valid?
        expect(@contentcomment.errors.full_messages).to include 'Userを入力してください'
      end
      it 'content_idが空では購入できない' do
        @contentcomment.content_id = nil
        @contentcomment.valid?
        expect(@contentcomment.errors.full_messages).to include 'Contentを入力してください'
      end
    end
  end
end
