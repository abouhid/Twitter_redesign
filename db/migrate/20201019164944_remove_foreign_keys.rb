# frozen_string_literal: true

class RemoveForeignKeys < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :replies, :users
    remove_foreign_key :likes, :tweets
    remove_foreign_key :likes, :users

    add_index :replies, :user_id
    add_index :likes, :tweet_id
    add_index :likes, :user_id
  end
end
