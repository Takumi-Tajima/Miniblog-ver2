class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :post, null: false, foreign_key: true

      t.timestamps
      t.index %i[user_id post_id], unique: true
    end
  end
end
