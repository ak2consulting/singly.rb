require "spec_helper"

describe Singly::Client do
  it "can be created without an access_token" do
    Singly::Client.new.should be_a(Singly::Client)
  end

  it "can be create with an access_token" do
    client = Singly::Client.new("mytoken")
    client.access_token.should == "mytoken"
  end

  context "with an access_token" do
    before do
      @client = Singly::Client.new("mytoken")
    end

    describe "#profiles" do
      before do
        stub_api(@client, "/profiles", 200)
        @profiles = @client.profiles
      end

      it "reports a unique user ID" do
        @profiles["id"].should == "myid"
      end

      it "reports all profiles" do
        @profiles["all"].should == [
          "123@twitter",
          "456@facebook"
        ]
      end

      it "reports each service's profile independently" do
        @profiles["facebook"].should == "456"
        @profiles["twitter"].should == "123"
      end
    end
  end

  context "without an access_token" do
    before do
      @client = Singly::Client.new
      stub_api(@client, "/profiles", 401)
    end

    describe "#profiles" do
      it "raises an exception" do
        lambda {
          @client.profiles
        }.should raise_error(Net::HTTPError)
      end
    end
  end
end
