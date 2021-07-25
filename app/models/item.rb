class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :pesticides
  belongs_to :shipping_charge
  belongs_to :shipping_source
  belongs_to :shipping_date
  
  with_options presence: true do
    validates :name
    validates :price
    validates :description
    validates :image
    validates :stock
    validates :amount
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :pesticides_id
      validates :shipping_charge_id
      validates :shipping_source_id
      validates :shipping_date_id
    end
  end
  with_options numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width numbers' } do
    validates :price
    validates :stock
  end
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'is out of setting range' }

  belongs_to :user
  # has_many :comments, dependent: :destroy
  has_one :order
  has_one_attached :image
end
