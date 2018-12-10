  module Zohoho
  class Account < ZohoObject
    DEFAULT_FIELDS = [
      'ACCOUNTID', 'Account Name', 'Phone', 'Fax', 'Employees',
      'Billing Street', 'Shipping Street', 'Billing City', 'Shipping City',
      'Billing State', 'Shipping State', 'Billing Code', 'Shipping Code',
      'Billing Country', 'Shipping Country', 'Description', 'Agreement',
      'Description', 'Website', 'Annual Revenue'
    ].freeze

    def initialize(h={})
      @@myFields.each do |f|
        self[f] = h[f] ||''
        end
    end
  end
end
