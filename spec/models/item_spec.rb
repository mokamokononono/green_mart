require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
  end

  describe '商品出品機能' do
    context '商品出品ができるとき' do
      it 'name、price, image, descriptionが存在し、
      かつcategory_id, condition_id, pesticides_id, shipping_charge_id, shipping_source_id, shipping_date_idがid=1以外であり,
      さらにpriceが300~9999999, amountが0~30, stockが0~9999999の範囲内であれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品ができないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'Imageを入力してください'
      end
      it '商品名nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '商品名を入力してください'
      end
      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の説明を入力してください'
      end
      it 'category_idが1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'カテゴリーを選択してください'
      end
      it 'condition_idが1では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '商品状態を選択してください'
      end
      it 'pesticides_idが1では登録できない' do
        @item.pesticides_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '農薬の有無を選択してください'
      end
      it 'shipping_charge_idが1では登録できない' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '配送料の負担を選択してください'
      end
      it 'shipping_source_idが1では登録できない' do
        @item.shipping_source_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '配送元の地域を選択してください'
      end
      it 'shipping_date_idが1では登録できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '配送までの日数を選択してください'
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '価格を入力してください'
      end
      it 'priceが全角ではで登録できない' do
        @item.price = '４７２８３'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は不正な値です. 半角数字で入力してください'
      end
      it 'priceが数字以外混じっているとば登録できない' do
        @item.price = '1f1f1f'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は不正な値です. 半角数字で入力してください'
      end
      it 'priceが半角英文字のみでは登録できない' do
        @item.price = 'aabfcc'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は不正な値です. 半角数字で入力してください'
      end
      it 'priceが300未満であれば登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は範囲外の値です。300 〜 9,999,999の範囲で入力してください'
      end
      it 'priceが9999999超過であれば登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は範囲外の値です。300 〜 9,999,999の範囲で入力してください'
      end
      it 'amountが空では登録できない' do
        @item.amount = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '重さを入力してください'
      end
      it 'amountが全角ではで登録できない' do
        @item.amount = '１１'
        @item.valid?
        expect(@item.errors.full_messages).to include '重さは不正な値です。半角数字（小数点可）で入力してください'
      end
      it 'amountが数字以外混じっているとば登録できない' do
        @item.amount = '1f'
        @item.valid?
        expect(@item.errors.full_messages).to include '重さは不正な値です。半角数字（小数点可）で入力してください'
      end
      it 'amountが半角英文字のみでは登録できない' do
        @item.amount = 'ac'
        @item.valid?
        expect(@item.errors.full_messages).to include '重さは不正な値です。半角数字（小数点可）で入力してください'
      end
      it 'amountが0未満であれば登録できない' do
        @item.amount = -1
        @item.valid?
        expect(@item.errors.full_messages).to include '重さは範囲外の値です。0 〜 30の範囲で入力してください'
      end
      it 'amountが30超過であれば登録できない' do
        @item.amount = 31
        @item.valid?
        expect(@item.errors.full_messages).to include '重さは範囲外の値です。0 〜 30の範囲で入力してください'
      end
      it 'stockが空では登録できない' do
        @item.stock = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '販売数を入力してください'
      end
      it 'stockが全角ではで登録できない' do
        @item.stock = '２８３'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売数は不正な値です. 半角数字で入力してください'
      end
      it 'stockが数字以外混じっているとば登録できない' do
        @item.stock = '1f1'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売数は不正な値です. 半角数字で入力してください'
      end
      it 'stockが半角英文字のみでは登録できない' do
        @item.stock = 'afc'
        @item.valid?
        expect(@item.errors.full_messages).to include '販売数は不正な値です. 半角数字で入力してください'
      end
      it 'stockが0未満であれば登録できない' do
        @item.stock = -1
        @item.valid?
        expect(@item.errors.full_messages).to include '販売数は範囲外の値です。0 〜 9,999,999の範囲で入力してください'
      end
      it 'stockが9999999超過であれば登録できない' do
        @item.stock = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include '販売数は範囲外の値です。0 〜 9,999,999の範囲で入力してください'
      end
      it 'user_idが空では購入できない' do
        @item.user_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'Userを入力してください'
      end
    end
  end
end
