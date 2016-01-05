require "test_helper"

class MembersControllerTest < ActionController::TestCase
	def setup
		login_as("taro")
	end

	## Though test pass, error occure in view
	test "update password" do
		member = session[:member_id] = FactoryGirl.create(:member)

		patch :update, id: member, member: FactoryGirl.attributes_for(:member, password: "happy", password_confirmation: "happy")
		assert_redirected_to member
	end

	test "index" do
		get :index
		assert_response :success
	end

	test "index before login" do
		logout
		get :index
		assert_response :forbidden
	end

	test "create" do
		post :create, member: attrs_with_image("valid.jpg", "image/jpeg")
		member = assigns[:member]
		assert_redirected_to member
		refute_nil member.image
	end

	test "fail to create" do
		post :create, member: attrs_with_image("invalid.jpg", "image/jpeg")
		assert_template "new"
		member = assigns[:member]
		assert member.errors.include?(:"image.uploaded_image")
	end

	private
	def attrs_with_image(fname, type)
		FactoryGirl.attributes_for(:member,
			image_attributes: {
				uploaded_image: uploaded_file(fname, type)
				})
	end
end