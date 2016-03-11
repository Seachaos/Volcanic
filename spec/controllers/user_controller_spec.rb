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
		let(:normalUser){
			user = User.new
			user.account = 'normalUser'
			user.password = 'testPassword'
			expect(user.save).to be true
			return user
		}
		it "success" do
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

		it "success, normalUser" do
			expect(userAdmin.id).to be >= 1
			expect(normalUser.id).to be >= 1
			post :login, {
				:user=>{
					:account =>'normalUser',
					:password =>'testPassword'
				}
			}
			expect(response.content_type).to eq("text/html")
			expect(response).to redirect_to :controller=>'home'
			expect(session[:isLogin]).to be true
			expect(session[:user_id]).not_to be == userAdmin.id
		end

		context  "failed" do
			it "wrong account" do
				expect(normalUser.id).to be >= 1
				accounts = [
					'normalUserx', 'xnormalUser', 'normal_User'
				]
				accounts.each do |account|
					post :login, {
						:user=>{
							:account =>account,
							:password =>'testPassword'
						}
					}
					expect(response.content_type).to eq("text/html")
					expect(response).to render_template(:login)
					expect(session[:isLogin].present?).to be false
				end
			end
			it "wrong password" do
				expect(normalUser.id).to be >= 1
				passwords = [
					'normalUserx', 'xnormalUser', 'normal_User'
				]
				passwords.each do |password|
					post :login, {
						:user=>{
							:account => 'normalUser',
							:password => password
						}
					}
					expect(response.content_type).to eq("text/html")
					expect(response).to render_template(:login)
					expect(session[:isLogin].present?).to be false
				end
			end
		end

	end
end
