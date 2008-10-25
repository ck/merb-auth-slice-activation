require File.dirname(__FILE__) + '/../spec_helper'

describe "Activation in the controller" do
  before(:all) do
    Merb::Router.reset!
    Merb::Router.prepare do
      match("/foos").to(:controller => "foo", :action => "index")
      add_slice(:merb_auth_slice_activation, :path_prefix => "activation")
    end

    User.all.destroy!
  end

  after(:all) do
    Merb::Router.reset!
  end

  before(:each) do
    @active_user = User.create( user_attributes(:login => "fred") )
    @active_user.activate!
    @user = User.create( user_attributes(:login => "barney", :email => "barney@example.com"))

    class TestStrategy < Merb::Authentication::Strategy
      def run!
        User.first(:login => request.params[:login])
      end
    end

    class Foo < Merb::Controller
      before :ensure_authenticated
      def index ; "INDEX" ; end
    end

  end

  after(:each) do
    User.all.destroy!
  end

  describe "Authenticating the session" do

    it "should successfully login a user who is activated" do
      @active_user.should be_active
      result = request("/foos", :params => {:login => "fred"})
      result.status.should == 200
      result.body.should == "INDEX"
    end

    it "should raise an error for a user who is not activated" do
      @user.should_not be_active
      result = request("/foos", :params => {:login => "barney"})
      result.should_not be_successful
      result.status.should == 401
    end

    it "should refuse entry until activated" do
      @user.should_not be_active
      result = request("/foos", :params => {:login => "barney"})
      result.status.should == 401
      @user.activate!
      result = request("/foos", :params => {:login => "barney"})
      result.should be_successful
      result.body.should == "INDEX"
    end

  end

  describe "activating a user" do
    it "should activate a user with the correct activation code" do
      ac = @user.activation_code
      ac.should_not be_nil
      @user.should_not be_active
      request("/activation/activate/#{ac}")
      User.first(:login => "barney").should be_active
    end

    it "should redirect after activation" do
      r = request("/activation/activate/#{@user.activation_code}")
      r.should redirect
    end
  end

end
