require File.dirname(__FILE__) + '/../spec_helper'

describe "Actviated User" do
  before(:all) do
    Merb::Router.prepare { add_slice(:merb_auth_slice_activation)}
  end

  after(:all) do
    Merb::Router.reset!
  end

  describe "ActivatedUser Mixin" do

    include ActivatedUserSpecHelper

    before(:all) do
      User.auto_migrate!
    end

    before(:each) do
      @user = User.new(user_attributes)
    end

    after(:each) do
      User.all.destroy!
    end

    it "should add the 'activated_at' property to the user model" do
      @user.should respond_to(:activated_at)
      @user.should respond_to(:activated_at=)
    end

    it "should add the 'activation_code' property to the user model" do
      @user.should respond_to(:activation_code)
      @user.should respond_to(:activation_code=)
    end

    it "should mark all new users as not activated" do
      @user.activated?.should == false
    end

    it "should mark all new users as not active" do
      @user.active?.should == false
    end

  end


  describe "ActivatedUser Mixin Activation Code" do

    include ActivatedUserSpecHelper

    before(:all) do
      User.auto_migrate!
    end

    after(:each) do
      User.all.destroy!
    end

    before(:each) do
      @user = User.new(user_attributes)
    end

    it "should set the activation_code" do
      @user.activation_code.should be_nil
      @user.save
      @user.activation_code.should_not be_nil
    end
  end


  describe "Activation" do

    include ActivatedUserSpecHelper

    before(:all) do
      User.auto_migrate!
    end

    before(:each) do
      User.all.destroy!
      @user = User.create(user_attributes)
    end

    after(:each) do
      User.all.destroy!
    end

    it "should mark users as active" do
      @user.should_not be_active
      @user.activate
      @user.should be_active
      @user.reload
      @user.should be_active
    end

    it "should mark user as (just) activated" do
      @user.activate
      @user.should be_recently_activated
    end

    it "should set the activated_at property to the current date and time" do
      now = DateTime.now
      DateTime.should_receive(:now).and_return(now)
      @user.activate
      @user.activated_at.should == now
    end

    it "should clear out the activation code" do
      @user.activation_code.should_not be_nil
      @user.activate
      @user.activation_code.should be_nil
    end

    it "should send out the activation notification" do
      @user.should_receive(:send_activation_notification)
      @user.activate
    end

  end
end
