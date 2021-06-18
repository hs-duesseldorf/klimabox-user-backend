class AddFavoritBlogposts < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_blogposts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :slug
      t.timestamps
    end
  end
end
