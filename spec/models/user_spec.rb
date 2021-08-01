require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nick_nameとemail、passwordとpassword_confirmation, kanji_family_nameとkanji_given_name, katakana_family_nameとkatakana_given_name, date_of_birth, farmland_name, farmland_region, hectare, exp_year, crops が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'farmland_name, farmland_region, hectare, exp_year, crops が存在しなくても登録できる' do
        @user.farmland_name = ''
        @user.farmland_region = ''
        @user.hectare = ''
        @user.exp_year = ''
        @user.crops = ''
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nick_nameが空では登録できない' do
        @user.nick_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'ニックネームを入力してください'
      end
      it 'kanji_family_nameが空では登録できない' do
        @user.kanji_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字（漢字）を入力してください'
      end
      it 'kanji_given_nameが空では登録できない' do
        @user.kanji_given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '名前（漢字）を入力してください'
      end
      it 'katakana_family_nameが空では登録できない' do
        @user.katakana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字（カナ）を入力してください'
      end
      it 'katakana_given_nameが空では登録できない' do
        @user.katakana_given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '名前（カナ）を入力してください'
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールを入力してください'
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードを入力してください'
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワード（確認用）とパスワードの入力が一致しません'
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end
      it '重複したnick_nameが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.nick_name = @user.nick_name
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'ニックネームはすでに存在します'
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it '名字は漢字・ひらがな・カタカナ以外では登録できない' do
        @user.kanji_family_name = 'Hawking'
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字（漢字）は不正な値です。全角文字で入力してください'
      end
      it '名前は漢字・ひらがな・カタカナ以外では登録できない' do
        @user.kanji_given_name = 'Michael'
        @user.valid?
        expect(@user.errors.full_messages).to include '名前（漢字）は不正な値です。全角文字で入力してください'
      end
      it '名字（ふりがな）はカタカナ以外では登録できない' do
        @user.katakana_family_name = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字（カナ）は不正な値です。全角カナで入力してください'
      end
      it '名前（ふりがな）はカタカナ以外では登録できない' do
        @user.katakana_given_name = 'はなこ'
        @user.valid?
        expect(@user.errors.full_messages).to include '名前（カナ）は不正な値です。全角カナで入力してください'
      end
      it 'パスワードは英字のみでは登録できない' do
        @user.password = 'abcdefg'
        @user.password_confirmation = 'abcdefj'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワード（確認用）とパスワードの入力が一致しません'
      end
      it 'パスワードは数字のみでは登録できない' do
        @user.password = '1234567890'
        @user.password_confirmation = '1234567890'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは不正な値です。半角英数字を含めて入力してください'
      end
      it 'パスワードは全角では登録できない' do
        @user.password = '全角のパスワード'
        @user.password_confirmation = '全角のパスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは不正な値です。半角英数字を含めて入力してください'
      end
      it 'emailに@が含まれていない場合、登録できないこと' do
        @user.email = 'sample.samp.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end
      it 'hectareが全角ではで登録できない' do
        @user.hectare = '４７２'
        @user.valid?
        expect(@user.errors.full_messages).to include '農業規模（ヘクタール）は不正な値です。半角数字（小数点可）で入力してください'
      end
      it 'hectareが数字以外混じっていると登録できない' do
        @user.hectare = '1f1f1f'
        @user.valid?
        expect(@user.errors.full_messages).to include '農業規模（ヘクタール）は不正な値です。半角数字（小数点可）で入力してください'
      end
      it 'hectareが半角英文字のみでは登録できない' do
        @user.hectare = 'aabfcc'
        @user.valid?
        expect(@user.errors.full_messages).to include '農業規模（ヘクタール）は不正な値です。半角数字（小数点可）で入力してください'
      end
      it 'exp_yearが全角ではで登録できない' do
        @user.exp_year = '１５'
        @user.valid?
        expect(@user.errors.full_messages).to include '経験年数は不正な値です。半角数字で入力してください'
      end
      it 'exp_yearが数字以外混じっているとば登録できない' do
        @user.exp_year = '1f'
        @user.valid?
        expect(@user.errors.full_messages).to include '経験年数は不正な値です。半角数字で入力してください'
      end
      it 'exp_yearが半角英文字のみでは登録できない' do
        @user.exp_year = 'af'
        @user.valid?
        expect(@user.errors.full_messages).to include '経験年数は不正な値です。半角数字で入力してください'
      end
    end
  end
end
