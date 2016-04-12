require 'rails_helper'

RSpec.describe DataResponse, type: :model do
	describe "DB test." do
		let(:name){ 'TestName' }

	 	it "should insert data" do
	 		dataTotal = 0
	 		data = DataResponse.new
	 		data.name = name
	 		data.path = name
	 		expect(data.save).to be true
	 		datas = DataResponse.where('name=?', name)
	 		expect(datas).not_to be_nil
	 		dataTotal = dataTotal + 1
	 		expect(datas.length).to eq(dataTotal)
		end

		it "shoud have datas" do
			dataTotal = 0
			datas = DataResponse.where('name=?', name)
			expect(datas.length).to eq(dataTotal)
			for i in 1..5 do
	 			data = DataResponse.new
		 		data.name = name
		 		data.path = name + i.to_s + 'HD'
		 		expect(data.save).to be true
		 		dataTotal = dataTotal + 1
	 		end
	 		datas = DataResponse.where('name=?', name)
	 		expect(datas.present?).to be true
	 		expect(datas.length).to be >= 1
	 		expect(datas.length).to eq(dataTotal)
		end
	end

	describe "Export/Import" do
		before(:each) do
			for i in 0...10
				data = DataResponse.new
				data.path = i.to_s + '_path'
				data.name = i.to_s + '_name'
				expect(data.save).to be true
			end
		end
		it "export success" do
			export = DataResponse.exportAll
			expect(export.length).to be > 10
			expect(export).to include '3_path'
		end

		it "import success" do
			export = DataResponse.exportAll
			DataResponse.all.each do |data|
				data.delete
			end
			expect(DataResponse.all.size).to be == 0
			expect(DataResponse.import(export)).to be true
			for i in 0...10
				path = i.to_s + '_path'
				name = i.to_s + '_name'
				data = DataResponse.where('name=? and path=?', name, path).first
				expect(data.present?).to be true
			end
		end
	end
end

