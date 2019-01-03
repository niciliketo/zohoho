module Zohoho
  class Lead < ZohoObject
    DEFAULT_FIELDS = [
      'Company', 'First Name', 'Last Name', ':Designation', 'Email', 'Phone',
      'Fax', 'Mobile', 'Website', 'Lead Source', 'Lead Status', 'Industry',
      'No of Employees', 'Annual Revenue', 'Email Opt Out', 'Skype ID',
      'Salutation', 'Street', 'City', 'State', 'Zip Code', 'Country',
      'Description', 'Annual Revenue', 'Rating'
    ].freeze

    def initialize(elements = {})
      # The default fields are expected by Zoho
      DEFAULT_FIELDS.each do |field|
        self[field] = elements.delete(field) || ''
      end
      # It is possible to pass arbitrary additional elements to a lead,
      # which will populate custom fields.
      elements.each { |key, value| self[key] = value } unless elements.empty?
    end
  end
end
