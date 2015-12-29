class ArticlesController < ApplicationController
	# before_action :article_params

	def index
		@articles = Article.order(released_at: :desc) 
 	end

 	def show 
 		@article = Article.find(params[:id])
 	end

 	def new
 		@article = Article.new
 	end

 	def edit
 		@article = Article.find(params[:id])
 	end

 	def create
 		@article = Article.new(params[:article])
 		if @article.save
 			redirect_to @article, notice: "ニュース記事を登録したよ"
 		else
 			render "new"
 		end
 		
 	end

 	def update
 		@article = Article.find(params[:id])
 		@article.assign_attributes(params[:article])
 		if @article.save
 			redirect_to @article, notice: "ニュース記事を更新したよん"
 		else
 			render "edit"
 		end
 	end

 	def destroy
 		@article = Article.find(params[:id])
 		@article.destroy
 		redirect_to :articles
 	end

 	private
 	def article_params
 		@article = Article.find(params[:id])
 	end

end
