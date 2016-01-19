require 'test_helper'

class ChatsControllerTest < ActionController::TestCase
  def setup
    @locale = 'en'
    @good_man = humans(:good_man)
    @chat_message = chats(:chat_message)
    @good_attributes = { text: 'good message' }
    @bad_attributes = { text: 'bad message' * 50 }
  end

  #----------------------------- index action ----------------------------------

  # logged out users must be redirected to login page
  test "index action: logged out users mustn't get access" do
    get :index, locale: @locale
    assert_redirected_to login_form_path
    assert_not flash.empty?
  end

  # logged in users must get access
  test 'index action: logged in users must get access' do
    log_in(@good_man.id)
    get :index, locale: @locale
    assert_response :success
  end

  #------------------------------ show action ----------------------------------

  # logged out users must be redirected to login page
  test "show action: logged out users mustn't get access" do
    get :show, id: @chat_message.id, locale: @locale
    assert_redirected_to login_form_path
    assert_not flash.empty?
  end

  # logged in users must get access
  test 'show action: logged in users must get access' do
    log_in(@good_man.id)
    get :show, id: @chat_message.id, locale: @locale
    assert_response :success
  end

  # wrong id mustn't lead to exception (behavior like new message has appeared)
  test "show acton: wrong id mustn't lead to exception" do
    log_in(@good_man.id)
    get :show, id: 'wrong_id', locale: @locale
    assert_response :success
    assert assigns(:messages)
  end

  #----------------------------- create action ---------------------------------

  # logged out users must be redirected
  test 'create action: logged out users must be redirected' do
    post :create, chat: @good_attributes, locale: @locale
    assert_redirected_to login_form_path
    assert_not flash.empty?
  end

  # logged in users must have access
  test 'create action: logged in users must have access' do
    log_in(@good_man.id)
    post :create, chat: @good_attributes, locale: @locale
    assert_response :success
  end

  # wrong attributes must be handled
  test 'create action: wrong attributes must be handled' do
    log_in(@good_man.id)
    post :create, chat: @bad_attributes, locale: @locale
    assert_response :success
    assert assigns(:message).errors.any?
  end

  # if "no attributes" request - must be handled
  test "create action: if 'no attributes' request - must be handled" do
    log_in(@good_man.id)
    post :create, locale: @locale
    assert_response :success
    assert assigns(:message).errors.any?
  end

  # if "wrong type attributes" request - must be handled
  test "create action: if 'wrong type attributes' request - must be handled" do
    log_in(@good_man.id)
    post :create, chat: 'lalala', locale: @locale
    assert_response :success
    assert assigns(:message).errors.any?
  end
end
