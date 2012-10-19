require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Zohoho::Connection" do

  before :each do
    @apikey = "qwertyy1234567890qwerty12345678"
    @conn = Zohoho::Connection.new('CRM', @apikey)
    vcr_config 'connection'
  end

  it "should make a simple call" do
    VCR.use_cassette('call', :record => :new_episodes) do
      @result = @conn.call('Contacts', 'getRecords')
    end

    @result.size.should == 20
  end
end
