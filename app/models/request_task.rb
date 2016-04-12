class RequestTask < ActiveRecord::Base

	def self.fromParams(params)
		params.permit(:name, :url, :method, :dataType, :data, :responseType)
	end

	def getRaw
		@raw_response
	end

	def postJsonGetJson(url, data)
		uri = URI(url)
		res = Net::HTTP.post_form(uri, data)
		@raw_response = res.body
		begin
			json = JSON.parse(res.body)
		rescue => ex
			return false
		end
		return json
	end
end
