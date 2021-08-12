class Content < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
    validates :image
  end

  belongs_to :user
  has_many :contentcomments, dependent: :destroy
  has_one_attached :image
end
