class AddProfileAndBlogUrlToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :profile, :string, null: false, default: '', limit: 200
    add_column :users, :blog_url, :string, null: false, default: ''
  end
end
