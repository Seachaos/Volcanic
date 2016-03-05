class ApiListController < ApplicationController

	def index
		@datas = DataResponse.all
		@datas.each do |data|
			data.path = root_url + 'test/' + data.path
		end
	end

	def list_request
		@datas = RequestTask.all
		render :action => :index
	end

	def create
		return if params.nil? or params[:post].nil?

		logger.info 'From POST:'
		logger.info params[:post].to_s

		data = DataResponse.new(params.require(:post).permit(:name, :path, :response))

		flash[:msgHas] = true
		if !(data.name.nil?) and data.save then
			flash[:msgContent] = 'Success'
			flash[:msgType] = :success
		else
			flash[:msgContent] = 'Failed'
			flash[:msgType] = :failed
		end
	end

	def test
		TestController.RenderResponse(self, params)
	end
end
