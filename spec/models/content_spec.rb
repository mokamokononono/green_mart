require 'rails_helper'

RSpec.describe Content, type: :model do
  before do
    user = FactoryBot.create(:user)
    @content = FactoryBot.build(:content, user_id: user.id)
  end

  describe 'ブログ投稿機能' do
    context 'ブログ投稿ができるとき' do
      it 'title、text, imageが存在すれば出品できる' do
        expect(@content).to be_valid
      end
    end
    context '商品出品ができないとき' do
      it 'imageが空では登録できない' do
        @content.image = nil
        @content.valid?
        expect(@content.errors.full_messages).to include 'Imageを入力してください'
      end
      it 'タイトルが空では登録できない' do
        @content.title = ''
        @content.valid?
        expect(@content.errors.full_messages).to include 'タイトルを入力してください'
      end
      it 'テキストが空では登録できない' do
        @content.text = ''
        @content.valid?
        expect(@content.errors.full_messages).to include 'テキストを入力してください'
      end
      it 'user_idが空では購入できない' do
        @content.user_id = nil
        @content.valid?
        expect(@content.errors.full_messages).to include 'Userを入力してください'
      end
    end
  end
end
