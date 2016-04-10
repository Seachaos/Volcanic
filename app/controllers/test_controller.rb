class TestController < ApplicationController
	
	protect_from_forgery :except => [:index]

	def index
		TestController.RenderResponse(self, params)
	end

	def self.RenderResponse(controller, params)
		path = params[:other]
		data = DataResponse.where('path=?',path).first
		unless data then
			TestController.writeLog(controller, 'FAILED', path)
			raise ActionController::RoutingError.new('No data response, please check path.')
			return
		end

		TestController.writeLog(controller, 'OK', path)
		# try response json data
		begin
			json = JSON.parse(data.response)
			controller.render :json=>json
			return
		rescue => e
			controller.render :html=>data.response.html_safe
			return
		end
	end

protected
	def self.writeLog(controller, tag, path, msg = '')
		log = LogDatum.new
		log.log_type = 'DATA_RESPONSE'
		log.tag = tag
		log.path = path
		log.msg = msg
		raw_params = controller.params.clone
		raw = {
			:params => raw_params
		}
		log.raw = raw.to_json.to_s
		log.save
	end
end
