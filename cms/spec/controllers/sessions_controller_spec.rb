require 'rails_helper'

describe Devise::SessionsController do
  # routes are mapped as:
  # match 'login' => 'session#create'
  # get 'logout' => 'session#destroy'


  describe "#create" do
    context "with valid credentials" do
      let :credentials do
        { :email => 'example@gmail.com', password: "12345678", password_confirmation: "12345678" }
      end

      let! :user do
        FactoryGirl.create(:user, credentials)
      end

      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, credentials
      end

      it "creates a user session" do
        puts session.inspect
        puts @request.env["rack.session"].inspect
        puts warden.inspect
        puts warden.session_serializer.session.inspect
        byebug
        session["warden.user.user.key"].should == user.id
      end
    end

    # ...
  end

  describe "#destroy" do
    context "when user logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        delete :destroy, {}, { :user_id => 123 } # the first hash is params, second is session
      end

      it "destroys user session" do
        session[:user_id].should be_nil
      end

      # ...
    end
  end
end