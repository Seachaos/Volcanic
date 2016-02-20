require 'rails_helper'

RSpec.describe ApiListController, type: :controller do

	describe "DataResponse test." do
		before(:each) do
			data = DataResponse.new
	 		data.name = 'get_test'
	 		data.save
	 	end

 		it "has data in db" do
 			datas = DataResponse.where('name=?', 'get_test')
	 		expect(datas).not_to be_nil
	 		expect(datas.length).to eq(1)
 		end

 		it "has data in db2" do
 			datas = DataResponse.where('name=?', 'get_test')
	 		expect(datas).not_to be_nil
	 		expect(datas.length).to eq(1)
 		end
	end
end
