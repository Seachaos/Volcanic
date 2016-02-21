class ApiListController < ApplicationController

	def index
		@datas = DataResponse.all
	end

	def create
		return if params.nil? or params[:post].nil?

		logger.info 'From POST:'
		logger.info params[:post].to_s

		data = DataResponse.new(params.require(:post).permit(:name, :path))

		flash[:msgHas] = true
		if !(data.name.nil?) and data.save then
			flash[:msgContent] = 'Success'
			flash[:msgType] = :success
		else
			flash[:msgContent] = 'Failed'
			flash[:msgType] = :failed
		end
	end
end
