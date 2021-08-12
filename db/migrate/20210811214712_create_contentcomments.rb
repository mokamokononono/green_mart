class CreateContentcomments < ActiveRecord::Migration[6.0]
  def change
    create_table :contentcomments do |t|
      t.string :text
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.timestamps
    end
  end
end
