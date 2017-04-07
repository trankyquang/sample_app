require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = I18n.t "ruby_on_rails_tut_sample_app"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", (I18n.t("help") + " | " + "#{@base_title}")
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", (I18n.t("about") + " | " + "#{@base_title}")
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", (I18n.t("contact") + " | " + "#{@base_title}")
  end


end
