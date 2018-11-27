module Zohoho
  # An account represents a paying customer in the CRM, generally a company.
  class Account < ZohoObject
    DEFAULT_FIELDS = [
      "ACCOUNTID", "Account Name", "Phone", "Fax", "Employees",
      "Billing Street", "Shipping Street", "Billing City", "Shipping City",
      "Billing State", "Shipping State", "Billing Code", "Shipping Code",
      "Billing Country","Shipping Country", "Description", "Agreement",
      "Description", "Website", "Annual Revenue"
    ]
  end
end
