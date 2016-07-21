class Snippet < ApplicationRecord
  belongs_to :user
	has_many :reviews
	acts_as_taggable
end
