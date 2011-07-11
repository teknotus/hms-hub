require 'test_helper'

class Admin::NotificationsControllerTest < ActionController::TestCase
  setup do
    @user = Factory.create(:user)
    with_valid_user_creds @user
  end

  test "accessing controller w/o creds should give 401 unauthorized" do
    without_auth_creds do
      get :index
      assert_response 401
    end
  end

  test "index should return a list of notifications (HTML)" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notifications)
  end

  test "index should return a list of notifications (JSON)" do
    4.times { Factory.create(:notification) }

    get :index, :format => :json
    assert_response :success
    assert_equal 4, json_response.count
  end

  test "show should return a notification (HTML)" do
    notification = Factory.create(:notification)

    get :show, :id => notification.id
    assert_response :success
    assert_not_nil assigns(:notification)
  end

  test "show should return a notification (JSON)" do
    notification = Factory.create(:notification)

    get :show, :id => notification.id, :format => :json
    assert_response :success
    assert_equal 'notification', json_response.keys.first
  end

end
