require 'rails_helper'

RSpec.describe DataResponse, type: :model do
	# pending "add some examples to (or delete) #{__FILE__}"

	describe "DB test." do
		dataTotal = 0;
		name = 'TestName'

		before(:each) do
			dataTotal = 0;
			name = 'TestName'
		end

	 	it "should insert data" do
	 		data = DataResponse.new
	 		data.name = name
	 		data.save
	 		datas = DataResponse.where('name=?', name)
	 		expect(datas).not_to be_nil
	 		dataTotal = dataTotal + 1
	 		expect(datas.length).to eq(dataTotal)
		end

		it "shoud have datas" do
			datas = DataResponse.where('name=?', name)
			expect(datas.length).to eq(dataTotal)
			for i in 0..5 do
	 			data = DataResponse.new
		 		data.name = name
		 		data.save
		 		dataTotal = dataTotal + 1
	 		end
	 		datas = DataResponse.where('name=?', name)
	 		expect(datas).not_to be_nil
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

