require "spec_helper"

TEST_URL = "https://api.singly.com/test"
TEST_SUCCESS = {"OK" => true}.to_json

describe Singly::ApiRequest do
  include Singly::ApiRequest

  describe "#api_base" do
    context "when specified by the user" do
      before do
        @api_base = "test.host"
      end

      it "uses it" do
        api_base.should == @api_base
      end
    end

    context "when left unspecified" do
      it "defaults to api.singly.com" do
        api_base.should == "api.singly.com"
      end
    end
  end

  describe "api_url" do
    it "prepends HTTPS" do
      api_url('/foo/bar').should =~ %r(^https://api.singly.com)
    end

    it "appends the path to the api_base" do
      api_url('/foo/bar').should =~ %r(api\.singly\.com/foo/bar$)
    end
  end

  describe "#get" do
    it "hits the correct endpoint" do
      stub_request(:get, "https://api.singly.com/test").
        to_return({:body => TEST_SUCCESS})
      get("/test")['OK'].should be_true
    end

    it "passes through query parameters" do
      stub_request(:get, "https://api.singly.com/test?foo=bar").
        to_return({:body => TEST_SUCCESS})
      get("/test", :foo => :bar)['OK'].should be_true
    end

    context "when @access_token is available" do
      before do
        @access_token = 'mytoken'
      end

      it "adds the access_token to the parameters" do
        stub_request(:get, "https://api.singly.com/test?access_token=mytoken").
          to_return({:body => TEST_SUCCESS})
        get('/test')['OK'].should be_true
      end
    end

    context "when @access_token is not defined" do
      it "leaves it out" do
        stub_request(:get, "https://api.singly.com/test").
          to_return({:body => TEST_SUCCESS})
        get('/test')['OK'].should be_true
      end
    end

    context "when the response is successful" do
      before do
        stub_request(:get, "https://api.singly.com/test").to_return({
          :status => 200,
          :body => {"foo" => "bar"}.to_json
        })
      end

      it "parses the body as JSON" do
        get("/test").should == {"foo" => "bar"}
      end
    end

    context "when the response is unsuccessful" do
      before do
        stub_request(:get, "https://api.singly.com/test").to_return({
          :status => 401
        })
      end

      it "raises the Net::HTTPResponse exception" do
        lambda {
          get("/test")
        }.should raise_error(Net::HTTPError)
      end
    end
  end
end
