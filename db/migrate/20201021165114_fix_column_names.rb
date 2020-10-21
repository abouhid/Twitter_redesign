# frozen_string_literal: true

class FixColumnNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :tweets, :user_id, :author_id
    rename_column :users, :gravatar_url, :coverimage
    rename_column :users, :name, :fullname
    add_column :users, :photo, :string
  end
end
