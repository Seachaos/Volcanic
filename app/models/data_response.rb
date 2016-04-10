class DataResponse < ActiveRecord::Base

	validates_presence_of :name
	validates_uniqueness_of :path

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

	def self.fromParams(data)
		data.permit(:name, :path, :response)
	end

	def self.import(datas)
		begin
			json = JSON.parse(datas)
		rescue => e
		end
		return false unless json.present?
		for data in json
			obj = DataResponse.new(data)
			return false unless obj.save
		end
		return true
	end

	def self.exportAll
		datas = [];
		DataResponse.all.each do |data|
			datas.push(data.export)
		end
		return datas.to_json.to_s;
	end

	def export
		resp = attributes
		resp[:id] = nil
		resp[:created_at] = nil
		resp[:updated_at] = nil
		resp.delete_if {|key, value|
			value.blank?
		}
		return resp
	end
end
