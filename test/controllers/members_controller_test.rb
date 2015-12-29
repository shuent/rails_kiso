require "test_helper"

class MembersControllerTest < ActionController::TestCase

	## Though test pass, error occure in view
	test "update password" do
		member = FactoryGirl.create(:member)
		patch :update, id: member, member: FactoryGirl.attributes_for(:member, password: "happy", password_confirmation: "happy")
		assert_redirected_to member
		p member.password
		p member.hashed_password
	end

end