class Condition < ActiveHash::Base
  self.data = [
    { id: 1, condition: '---' },
    { id: 2, condition: 'S（非常に状態が良い）' }, { id: 3, condition: 'A（店に販売できる）' }, { id: 4, condition: 'B（キズ多め・可食できる）' },
    { id: 5, condition: 'アソート（上記の混合販売）' }
  ]

  include ActiveHash::Associations
  has_many :items
end
