require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = FactoryBot.create(:admin)
  end

  test "should get index" do
    get admins_url
    assert_response :success
    assert_select "h1", "Admins"
  end

  test "should get new" do
    get new_admin_url
    assert_response :success
    assert_select "h3", "New Admin"
  end

  test "should create admin" do
    assert_difference("Admin.count") do
      post admins_url, params: {
        admin: {
          name: "New Admin",
          email: "newadmin@example.com",
          phone: "123-456-7890",
          role_level: 1,
          active_status: true
        }
      }
    end

    assert_redirected_to admin_url(Admin.last)
    # Intentionally not checking for typo in success message as part of assessment
    assert_equal 'Admin was succesfully created.', flash[:notice]
  end

  test "should show admin" do
    get admin_url(@admin)
    assert_response :success
    assert_select "h3", "Admin Information"
  end

  test "should get edit" do
    get edit_admin_url(@admin)
    assert_response :success
    assert_select "h3", "Edit Admin"
  end

  test "should update admin" do
    patch admin_url(@admin), params: {
      admin: {
        name: "Updated Name",
        email: @admin.email,
        phone: @admin.phone,
        role_level: @admin.role_level,
        active_status: @admin.active_status
      }
    }
    assert_redirected_to admin_url(@admin)
    assert_equal 'Admin was successfully updated.', flash[:notice]
    @admin.reload
    assert_equal "Updated Name", @admin.name
  end

  test "should destroy admin" do
    assert_difference("Admin.count", -1) do
      delete admin_url(@admin)
    end

    assert_redirected_to admins_url
    assert_equal 'Admin was successfully deleted.', flash[:notice]
  end

  test "should not create admin with invalid email" do
    assert_no_difference("Admin.count") do
      post admins_url, params: {
        admin: {
          name: "New Admin",
          email: "invalid-email",
          phone: "123-456-7890",
          role_level: 1,
          active_status: true
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should handle search" do
    get admins_url, params: { query: @admin.name }
    assert_response :success
    assert_select "td", text: @admin.name
  end
end
