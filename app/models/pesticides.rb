class Pesticides < ActiveHash::Base
  self.data = [
    { id: 1, condition: '---' },
    { id: 2, condition: 'あり' }, { id: 3, condition: 'なし' }
  ]

  include ActiveHash::Associations
  has_many :items
end
