require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Zohoho::CRM" do

  before :each do
    @apikey = "qwertyy1234567890qwerty12345678"
    @crm = Zohoho::Crm.new(@apikey)
    vcr_config 'crm'
  end

  it 'should get contact John Doe20' do
    VCR.use_cassette('contact', :record => :new_episodes) do
      @contact = @crm.contact "John Doe20"
    end
    @contact["CONTACTID"].should == "232068000001517115"
  end

  it 'should get single name contact Doe3' do
    VCR.use_cassette('contact_single', :record => :new_episodes) do
      @contact = @crm.contact "Doe3"
    end
    @contact["CONTACTID"].should == "232068000001517013"
  end

  it 'should return nil for Johnny Depp' do
    VCR.use_cassette('contact', :record => :new_episodes) do
      @contact = @crm.contact "Johnny Depp"
    end
    @contact.should == nil
  end

  it 'should add Johnny Depp as a new contact' do
    VCR.use_cassette('add_contact', :record => :new_episodes) do
      @contact = @crm.add_contact "Johnny Depp"
    end
    @contact.should == "232068000001518001"
  end

  it 'should add a note to Johnny Depp' do
    VCR.use_cassette('note', :record => :new_episodes) do
      @note = @crm.post_note "232068000001518001", "Note to self", "Don't do that again"
    end
    @note.should == "232068000001519001"
  end

  it 'should add Charlie Sheen as a new contact' do
    VCR.use_cassette('add_complicated_contact', :record => :new_episodes) do
      contact = Zohoho::Contact.new
      contact.keys.each {|k| contact[k] = k} #Put the keyname as the val, so we can test all fields received OK
      contact['ACCOUNTID'] = nil
      contact['First Name'] = 'Charlie'
      contact['Last Name'] = 'Sheen'
      @res = @crm.add_object(contact)
    end
    @res.should == "232068000001518003"
  end
end
