class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :tweet_id
      t.integer :user_id
    end
    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :likes, :tweets, column: :tweet_id
  end
end
