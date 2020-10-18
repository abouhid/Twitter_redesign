class Tweet < ApplicationRecord
    validates :content, presence: true, length: { maximum: 140,
        too_long: '140 characters in post is the maximum allowed.' }
    belongs_to :user
end
