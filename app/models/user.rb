class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nick_name, uniqueness: true
    with_options format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は不正な値です。全角文字で入力してください' } do
      validates :kanji_family_name
      validates :kanji_given_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'は不正な値です。全角カナで入力してください' } do
      validates :katakana_family_name
      validates :katakana_given_name
    end
    validates :date_of_birth
  end
  validates :password,
            format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/, message: 'は不正な値です。半角英数字を含めて入力してください' },
            on: :create
  validates :hectare, numericality: { with: /\A[0-9]+(\.[0-9]+)?\z/, message: 'は不正な値です。半角数字（小数点可）で入力してください' },
            allow_blank: true
  validates :exp_year, numericality: { with: /\A[0-9]+\z/, message: 'は不正な値です。半角数字で入力してください' }, length: { maximum: 2, message: 'は不正な値です。2桁までの数字で入力してください' },
            allow_blank: true


  has_many :items, dependent: :destroy
  has_many :content, dependent: :destroy
  # has_many :comments, dependent: :destroy
  has_many :orders

  # allow users to update their accounts without passwords
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    
    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
