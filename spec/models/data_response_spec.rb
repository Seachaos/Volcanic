require 'rails_helper'

RSpec.describe DataResponse, type: :model do
	# pending "add some examples to (or delete) #{__FILE__}"

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

	describe "POST test" do
		it "shoud get json" do
			url = 'http://www.myandroid.tw/test/post.php'
			data = { 'aa':'bb', 'cc':'dd'}
			resp = DataResponse.postGetJson(url,data)
			expect(resp).not_to be false
		end
	end
end

