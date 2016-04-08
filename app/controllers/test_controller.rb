class TestController < ApplicationController
	
	protect_from_forgery :except => [:index]

	def index
		TestController.RenderResponse(self, params)
	end

	def self.RenderResponse(controller, params)
		path = params[:other]
		data = DataResponse.where('path=?',path).first
		unless data then
			raise ActionController::RoutingError.new('No data response, please check path.')
			return
		end

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
end
