require 'rails_helper'

describe 'Zohoho::Connection' do
  before :each do
    @apikey = 'dummy_api_key'
    @conn = Zohoho::Connection.new('CRM', @apikey, true)
    vcr_configure('connection')
  end

  it 'should make a simple call' do
    VCR.use_cassette('call', record: :new_episodes) do
      @result = @conn.call('Contacts', 'getRecords')
    end

    expect(@result.size).to eq(20)
  end
end
