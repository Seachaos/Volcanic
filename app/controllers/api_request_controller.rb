class ApiRequestController < ApplicationController

	before_filter :require_admin

	def index
		@datas = RequestTask.all
		render :action => :index
	end

	def create
		@data = RequestTask.new
		@data.method = 'POST'
		@data.dataType = 'json'
		@data.responseType = 'json'

		flash.now[:title] = 'Create Request Task'
		return if params.nil? or params[:request_task].nil?

		if params[:id].present? then
			data = RequestTask.find_by_id(params[:id])
			unless data then
				redirect_to :action=>'index'
				return
			end
			data.update(dataRequestFromParams)
		else
			data = RequestTask.new(dataRequestFromParams)
		end
		@data = data

		if !(data.name.nil?) and data.save then
			redirect_to :action=>'index'
			return
		else
			flash.now[:emsg] = 'Save Failed'
			return
		end
	end

	def make_request
		@content = 'NONE'
		task = RequestTask.find_by_id(params[:id])
		@task = task
		unless task.present? then
			flash.now[:emsg] = 'Request Task Error!'
			return
		end


		# TODO Handle data type
		case task.dataType
			when 'json'
				begin
					data = JSON.parse(task.data).to_hash
					@content = task.postJsonGetJson(task.url, data)
					unless @content.present?
						flash.now[:emsg] = 'Response format error!' 
						@content = 'Response format error!' 
						@content += "\n" + task.getRaw.to_s
					end
				rescue  => e
					flash.now[:emsg] = 'Request data format error!'
					@content = e.to_s
				end
			else
				flash.now[:emsg] = 'Request type node define'
				@content = 'Request type node define'
		end
	end

private
	def dataRequestFromParams
		RequestTask.fromParams(params.require(:request_task))
	end
end
