class ReviewsController < ApplicationController
	def new
		@snippet = Snippet.find(params[:snippet_id])
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.snippet = Snippet.find(params[:snippet_id])
    if @review.save
      redirect_to snippet_path(params[:snippet_id])
    else
      flash[:error]='Cannot review'
      redirect_to snippet_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:review)
  end
end
