class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create]

	def new
	end

	def create
		
	end

	def index
	end

#filters.
	def logged_in_user
		unless logged_in?
			flash[:danger]= "you have to be logged in."
			redirect_to login_url
		end
	end
end
