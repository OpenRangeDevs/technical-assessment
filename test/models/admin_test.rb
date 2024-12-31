require "test_helper"

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = FactoryBot.build(:admin)
  end

  test "should be valid" do
    assert @admin.valid?
  end

  test "name should be present" do
    @admin.name = "   "
    assert_not @admin.valid?
  end

  test "email should be present" do
    @admin.email = "   "
    assert_not @admin.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @admin.email = valid_address
      assert @admin.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @admin.email = invalid_address
      assert_not @admin.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_admin = @admin.dup
    @admin.save
    assert_not duplicate_admin.valid?
  end

  test "role_level should be within bounds" do
    @admin.role_level = 6
    assert_not @admin.valid?
    @admin.role_level = -1
    assert_not @admin.valid?
    @admin.role_level = 3
    assert @admin.valid?
  end

  test "phone format should be valid" do
    valid_phones = ["+1234567890", "123-456-7890", "123 456 7890"]
    valid_phones.each do |valid_phone|
      @admin.phone = valid_phone
      assert @admin.valid?, "#{valid_phone.inspect} should be valid"
    end

    invalid_phones = ["123", "abcd", "123-abc-defg"]
    invalid_phones.each do |invalid_phone|
      @admin.phone = invalid_phone
      assert_not @admin.valid?, "#{invalid_phone.inspect} should be invalid"
    end
  end

  test "active scope returns only active admins" do
    active_admin = FactoryBot.create(:admin, active_status: true)
    inactive_admin = FactoryBot.create(:admin, active_status: false)

    assert_includes Admin.active, active_admin
    assert_not_includes Admin.active, inactive_admin
  end
end
