require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入商品の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(0.1)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        @order_address.errors.full_messages
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'zip_codeが空だと保存できないこと' do
        @order_address.zip_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号を入力してください')
      end
      it 'zip_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.zip_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です。ハイフン(-)を含めた半角数字で入力してください')
      end
      it 'zip_codeが全角だと保存できないこと' do
        @order_address.zip_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です。ハイフン(-)を含めた半角数字で入力してください')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it 'cityは空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('市町村を入力してください')
      end
      it 'addressは空だと保存できないこと' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('番地を入力してください')
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'phone_numberが全角数字だと保存できないこと' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です。半角数字で入力してください')
      end
      it 'phone_numberが11桁以内でないと保存できないこと' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です。11桁の電話番号を入力してください')
      end
      it ' 英数混合では登録できないこと' do
        @order_address.phone_number = '090abcd1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です。半角数字で入力してください')
      end
      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tokenを入力してください')
      end
      it 'item_idが空では購入できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Itemを入力してください'
      end
      it 'user_idが空では購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Userを入力してください'
      end
    end
  end
end
