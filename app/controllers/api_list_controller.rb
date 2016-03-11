class ApiListController < ApplicationController

	before_filter :require_admin

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

	def edit
		if params[:id] then
			data = DataResponse.find_by_id(params[:id])
			unless data then
				redirect_to :action=>'index'
				return
			end
		end
		@data = data
		render :action=>'create'
	end

	def create
		@data = DataResponse.new
		return if params.nil? or params[:data_response].nil?

		if params[:id] then
			data = DataResponse.find_by_id(params[:id])
			unless data then
				redirect_to :action=>'index'
				return
			end
			data.update(dataResponseFromParams)
		else
			data = DataResponse.new(dataResponseFromParams)
		end
		@data = data

		flash[:msgHas] = true
		if !(data.name.nil?) and data.save then
			redirect_to :action=>'index'
			return
		else
			flash[:msgContent] = 'Failed'
			flash[:msgType] = :failed
		end
	end

	def test
		TestController.RenderResponse(self, params)
	end

private
	def dataResponseFromParams
		params.require(:data_response).permit(:name, :path, :response)
	end
end
