class CreateRelationships < ActiveRecord::Migration[8.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false, index: true

      t.timestamps
      t.index %i[follower_id followed_id], unique: true
    end
  end
end
