class AddSnippetToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :snippet, foreign_key: true
  end
end
