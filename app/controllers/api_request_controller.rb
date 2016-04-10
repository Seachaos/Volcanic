class ApiRequestController < ApplicationController
	def index
		@datas = RequestTask.all
		render :action => :index
	end
end
