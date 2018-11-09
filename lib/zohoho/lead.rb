module Zohoho
  class Lead < ZohoObject
    @@myFields = ["Company", "First Name", "Last Name", ":Designation", "Email", "Phone", "Fax", "Mobile", "Website", "Lead Source", "Lead Status", "Industry", "No of Employees",
    "Annual Revenue", "Email Opt Out", "Skype ID", "Salutation", "Street", "City", "State", "Zip Code", "Country", "Description", "Annual Revenue", "Rating"]
   #attr_accessor *@@myFields

    def initialize(h={})
      @@myFields.each do |f|
        self[f] = h[f] ||''
        end
    end
  end
end
