class DataResponse < ActiveRecord::Base

	def self.postGetJson(url, data)
		uri = URI(url)
		res = Net::HTTP.post_form(uri, data)
		puts res.body
		begin
			json = JSON.parse(res.body)
		rescue => ex
			return false
		end
		return json
	end
end
