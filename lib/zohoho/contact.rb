module Zohoho
  # Represents a Contact, or an individual within the CRM.
  class Contact < ZohoObject
    DEFAULT_FIELDS = [
      'ACCOUNTID', 'Contact Owner', 'Lead Source', 'First Name', 'Last Name',
      'Email', 'Title', 'Department', 'Phone', 'Home Phone', 'Fax', 'Mobile',
      'Date of Birth', 'Assistant', 'Asst Phone', 'Reports To',
      'Mailing Street', 'Other Street', 'Mailing City', 'Other City',
      'Mailing State', 'Other State', 'Mailing Zip', 'Other Zip',
      'Mailing Country', 'Other Country', 'Description', 'Skype ID',
      'Salutation', 'Email3', 'Lead Source Detail', 'Registration Status',
      'Email Opt Out', 'Secondary Email', 'Website'
    ].freeze

    def initialize(elements = {})
      # The default fields are expected by Zoho
      DEFAULT_FIELDS.each do |field|
        self[field] = elements.delete(field) || ''
      end
      # It is possible to pass arbitrary additional elements to a contact, which
      # will populate custom fields.
      elements.each { |key, value| self[key] = value } unless elements.empty?
    end
  end
end
