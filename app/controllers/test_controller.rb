class TestController < ApplicationController
	def index
		@datas = DataResponse.all
	end
end
