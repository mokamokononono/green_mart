class Contentcomment < ApplicationRecord
  validates :text, presence: true

  belongs_to :user
  belongs_to :content
end
