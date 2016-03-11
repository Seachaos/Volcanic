require 'rails_helper'

RSpec.describe UserController, type: :controller do
	describe "About login" do
		let(:userAdmin){
			user = User.new
			user.account = 'testAdminAccount'
			user.password = 'testPassword'
			user.permission = 'admin'
			expect(user.save).to be true
			return user
		}
		it "login success" do
			expect(userAdmin.id).to be >= 1
			post :login, {
				:user=>{
					:account =>'testAdminAccount',
					:password =>'testPassword'
				}
			}
			expect(response.content_type).to eq("text/html")
			expect(response).to redirect_to :controller=>'home'
			expect(session[:isLogin]).to be true
			expect(session[:user_id]).to be == userAdmin.id
		end

		pending "test multi user"
		pending "test user error"

	end
end
