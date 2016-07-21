class Tag < ApplicationRecord

	has_many :taggings
	has_many :snippets, through: :taggings

	def to_s
    name
  end
end
