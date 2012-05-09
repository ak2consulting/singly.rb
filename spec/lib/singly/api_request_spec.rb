require "spec_helper"

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
      HTTParty.should_receive(:get).
        with("https://api.singly.com/test", anything)
      get("/test")
    end

    it "passes through query parameters" do
      HTTParty.should_receive(:get).
        with(anything, {:query => {:foo => :bar}})
      get("/test", :foo => :bar)
    end

    context "when @access_token is available" do
      before do
        @access_token = 'mytoken'
      end

      it "adds the access_token to the parameters" do
        HTTParty.should_receive(:get).
          with(anything, {:query => {:access_token => @access_token}})
        get('/test')
      end
    end

    context "when @access_token is not defined" do
      it "leaves it out" do
        HTTParty.should_receive(:get).with(anything, {:query => {}})
        get('/test')
      end
    end
  end
end
