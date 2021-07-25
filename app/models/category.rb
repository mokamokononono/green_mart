class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '水稲' },
    { id: 3, name: '陸稲' },
    { id: 4, name: '麦類' },
    { id: 5, name: '雑穀' },
    { id: 6, name: '豆類' },
    { id: 7, name: 'いも類' },
    { id: 8, name: '野菜' },
    { id: 9, name: '果樹' },
    { id: 10, name: '工芸農作物' },
    { id: 11, name: '飼肥料作物' },
    { id: 12, name: '花き' },
    { id: 13, name: '薬用作物' },
    { id: 14, name: '採取用作物' },
  ]

  include ActiveHash::Associations
  has_many :items
end
