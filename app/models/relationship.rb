# frozen_string_literal: true

class Relationship < ApplicationRecord
  # attr_accessible :followed_id

  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end
