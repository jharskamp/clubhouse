require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user=users(:michael)
	end

	test "login with invalid information" do
		get login_path #goes to login screen
		assert_template 'sessions/new' #makes sure its at login screen
		post login_path, session: {email: "", password: " "} #enters invalid login information
		assert_template 'sessions/new' #makes sure its redirected back to login screen
		assert_not flash.empty? #makes sure the flash fired off as its supposed to
		get root_path #goes back to home screen
		assert flash.empty? #checks to see if the flash is still on. it shouldn't be.
	end

	test "login with valid information followed by logout" do
		get login_path #goes to log in screen
		post login_path, session: {email: @user.email, password: 'password'}
		assert is_logged_in?
		assert_redirected_to @user #makes sure we got sent to the user profile page
		follow_redirect! #actually sends us to the page
		assert_template 'users/show' #checks to see if we're on the users/show page
		assert_select "a[href=?]", login_path, count: 0 #should be 0 links to login
    	assert_select "a[href=?]", logout_path #looks for log out link
    	assert_select "a[href=?]", user_path(@user) #looks for user link
    	delete logout_path
	    assert_not is_logged_in?
	    assert_redirected_to root_url
	    follow_redirect!
	    assert_select "a[href=?]", login_path
	    assert_select "a[href=?]", logout_path,      count: 0
	    assert_select "a[href=?]", user_path(@user), count: 0
  end
 

end
