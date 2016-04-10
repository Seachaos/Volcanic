class ApiListController < ApplicationController

	before_filter :require_admin

	def index
		@datas = DataResponse.all
		@datas.each do |data|
			data.path = root_url + 'test/' + data.path
		end
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
		flash.now[:title] = 'Edit: ' + data.name
		render :action=>'create'
	end

	def copy
		if params[:id] then
			data = DataResponse.find_by_id(params[:id])
			unless data then
				redirect_to :action=>'index'
				return
			end
			data = DataResponse.new(data.attributes)
			data.id = nil
			@isCopy = true
		end
		@data = data
		flash.now[:title] = 'Copy: ' + data.name
		render :action=>'create'
	end

	def create
		@data = DataResponse.new
		flash.now[:title] = 'Create'
		return if params.nil? or params[:data_response].nil?

		if params[:id].present? then
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

		# check path duplicate
		exists = DataResponse.where('path =? ', params[:data_response][:path])
		if exists.present? then
			unless exists.first.id == data.id then
				flash.now[:emsg] = 'Path has exists.'
				return;
			end
		end

		if !(data.name.nil?) and data.save then
			redirect_to :action=>'index'
			return
		else
			flash.now[:emsg] = 'Save Failed'
			return
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
