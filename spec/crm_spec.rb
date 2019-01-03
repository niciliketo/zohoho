require 'rails_helper'

describe 'Zohoho::CRM' do
  before :each do
    @apikey = 'dummy_api_key'
    @crm = Zohoho::Crm.new(@apikey, true)
    vcr_configure('crm')
  end

  it 'should get contact Johnny Depp' do
    VCR.use_cassette('contact', record: :new_episodes) do
      @contact = @crm.contact_with_name 'Johnny Depp'
    end
    expect(@contact['CONTACTID']).to eq('2033736000000879001')
  end

  it 'should get single name contact Doe3' do
    VCR.use_cassette('contact_single', record: :new_episodes) do
      @contact = @crm.contact_with_name 'Doe3'
    end
    expect(@contact['CONTACTID']).to eq('2033736000000880015')
  end

  it 'should return nil for Johnny Weismuller' do
    VCR.use_cassette('contact', record: :new_episodes) do
      @contact = @crm.contact_with_name 'Johnny Weismuller'
    end
    expect(@contact).to be_nil
  end

  it 'should add Johnny Depp as a new contact' do
    VCR.use_cassette('add_contact', record: :new_episodes) do
      @contact = @crm.add_contact 'Johnny Depp'
    end
    expect(@contact).to eq('2033736000000879001')
  end

  it 'should add a note to Johnny Depp' do
    VCR.use_cassette('note', record: :new_episodes) do
      @note = @crm.post_note(
        '2033736000000879001',
        'Note to self',
        "Don't do that again"
      )
    end
    expect(@note).to eq('2033736000000881001')
  end

  it 'should add Charlie Sheen as a new contact' do
    VCR.use_cassette('add_complicated_contact', record: :new_episodes) do
      contact = Zohoho::Contact.new
      # Put the keyname as the val, so we can test all fields received OK
      contact.keys.each { |k| contact[k] = k }
      contact['ACCOUNTID'] = nil
      contact['First Name'] = 'Charlie'
      contact['Last Name'] = 'Sheen'
      @res = @crm.add_object(contact)
    end
    expect(@res).to eq('2033736000000880001')
  end

  it 'should get contact by id' do
    VCR.use_cassette('get_contact_by_id', record: :new_episodes) do
      @contact = @crm.contact_with_id '2033736000000879001'
    end
    expect(@contact['First Name']).to eq('Johnny')
  end

  it 'should get contact by email' do
    VCR.use_cassette('get_contact_by_email', record: :new_episodes) do
      @contact = @crm.contact_with_email 'jdepp@md.com'
    end
    expect(@contact['First Name']).to eq('Johnny')
  end

  it 'should get account by id' do
    VCR.use_cassette('get_account_by_id', record: :new_episodes) do
      @account = @crm.account_with_id '2033736000000197007'
    end
    expect(@account['Account Name']).to eq('Market Dojo Ltd')
  end
end
