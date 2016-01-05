class ArticlesController < ApplicationController
	# before_action :article_params
	before_action :login_required, except: [:index, :show]

	def index
		@articles = Article.open.readable_for(current_member)
			.order(released_at: :desc).paginate(page: params[:page], per_page: 5)
 	end

 	def show 
 		@article = Article.open.readable_for(current_member).find(params[:id])
 	end

 	private
end
