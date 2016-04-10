class LogController < ApplicationController

	before_filter :require_admin

	def index
		@logData = LogDatum.all.order('id desc')
	end
end
