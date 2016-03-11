require 'rails_helper'


RSpec.describe ApiListController, type: :controller do

	let(:createAPIListParams){
		return {
			:data_response => {
				:name => 'Name_TEST',
				:path => 'here_is_path',
				:response => 'RESPONSE'
			}
		}
	}
	let(:userAdmin){
		user = User.new
		user.account = 'testAdminAccount'
		user.password = 'testPassword'
		user.permission = 'admin'
		expect(user.save).to be true
		return user
	}
	let(:session){
		return {
			:isLogin => true,
			:user_id => userAdmin.id
		}
	}

	describe "Create" do
		before(:each) do
			post :create, createAPIListParams, session
		end

		context "when post" do
			it "has response" do
				# expect(response).to have_http_status(:success)
				expect(response).to redirect_to :action=>:index
				expect(response.body).not_to be_nil
			end
			it "has data" do
				data = DataResponse.where('name=?', 'Name_TEST').first
				expect(data).not_to be_nil
				expect(data.id).to be >= 1
				expect(data.response).to eq('RESPONSE')
			end
		end
	end

	describe "Edit and Delete" do
		let(:data_id){
			data = DataResponse.where('name=?', 'Name_TEST').first
			expect(data).not_to be_nil
			expect(data.id).to be >= 1
		}
		before(:each) do
			post :create, createAPIListParams, session
		end

		it "can modify" do
			params = createAPIListParams
			params[:data_response][:name] = 'I_Modify'
			params[:id] = data_id
			post :create, params
			data = DataResponse.where('name=?', 'I_Modify').first
			expect(data).not_to be_nil
			expect(data.id).to be >= 1
		end
	end

	describe "Response Format" do
		name = 'Name_TEST'
		path = 'TEST_PATH'

		context "JSON" do
			before(:each) do
				post :create, {
					:data_response => {
						:name => name,
						:path => path,
						:response => '{"aa":"bb","cc":"dd"}'
					}
				}, session

				post :test, {
					:other => path
				}
			end

			it "has response" do
				expect(response).to have_http_status(:success)
				expect(response.body).not_to be_nil
			end

			it "has one data in db" do
				datas = DataResponse.where('name=?', name)
				expect(datas.first).not_to be_nil
				expect(datas.length).to be == 1
			end

			it "format correct" do
				expect(response.content_type).to eq("application/json")
				json = JSON.parse(response.body)
				expect(json['aa']).to eq('bb')
			end
		end

		context "HTML" do
			before(:each) do
				post :create, {
					:data_response => {
						:name => name,
						:path => path,
						:response => '<h1>Here is HTML</h1>'
					}
				}, session

				post :test, {
					:other => path
				}
			end

			it "has one data in db" do
				datas = DataResponse.where('name=?', 'Name_TEST')
				expect(datas.first).not_to be_nil
				expect(datas.length).to be == 1
			end


			it "has response" do
				expect(response).to have_http_status(:success)
				expect(response.body).not_to be_nil
			end

			it "format correct" do
				expect(response.content_type).to eq("text/html")
				expect(response.body).to eq('<h1>Here is HTML</h1>')
			end
		end
	end

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

 		it "has data in db" do
 			datas = DataResponse.where('name=?', 'get_test')
	 		expect(datas).not_to be_nil
	 		expect(datas.length).to eq(1)
 		end
	end
end
