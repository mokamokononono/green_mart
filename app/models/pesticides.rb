class Pesticides < ActiveHash::Base
  self.data = [
    { id: 1, condition: '---' },
    { id: 2, condition: 'ăă' }, { id: 3, condition: 'ăȘă' }
  ]

  include ActiveHash::Associations
  has_many :items
end
