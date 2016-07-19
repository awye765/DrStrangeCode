class UserController < ApplicationController
	def index
		@user = User.find_by(id: params[:id])
		@snippets = @user.snippets
	end
end
