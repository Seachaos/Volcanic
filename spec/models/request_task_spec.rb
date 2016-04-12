require 'rails_helper'

RSpec.describe RequestTask, type: :model do
  
	describe "POST test" do
		it "shoud get json" do
			url = 'http://www.myandroid.tw/test/post.php'
			data = { 'aa':'bb', 'cc':'dd'}
			resp = RequestTask.new.postJsonGetJson(url,data)
			expect(resp).not_to be false
		end
	end
	
end
