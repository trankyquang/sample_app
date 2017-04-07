require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = I18n.t "ruby_on_rails_tut_sample_app"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", (I18n.t("help") + " | " + "#{@base_title}")
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", (I18n.t("about") + " | " + "#{@base_title}")
  end
end
