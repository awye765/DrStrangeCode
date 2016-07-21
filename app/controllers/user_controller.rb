class UserController < ApplicationController
	def index
		@user = User.find_by(id: params[:id])
		@snippets = @user.snippets
		@reviews = @user.reviews.map { |r| Snippet.find_by(id: r.snippet_id) }
	end
end
