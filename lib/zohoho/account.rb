module Zohoho
  # An account represents a paying customer in the CRM, generally a company.
  class Account < ZohoObject
    DEFAULT_FIELDS = [
      'ACCOUNTID', 'Account Name', 'Phone', 'Fax', 'Employees',
      'Billing Street', 'Shipping Street', 'Billing City', 'Shipping City',
      'Billing State', 'Shipping State', 'Billing Code', 'Shipping Code',
      'Billing Country', 'Shipping Country', 'Description', 'Agreement',
      'Description', 'Website', 'Annual Revenue'
    ].freeze

    def initialize(elements = {})
      # The default fields are expected by Zoho
      DEFAULT_FIELDS.each do |field|
        self[field] = elements.delete(field) || ''
      end
      # It is possible to pass arbitrary additional elements to an account,
      # which will populate custom fields.
      elements.each { |key, value| self[key] = value } unless elements.empty?
    end
  end
end
