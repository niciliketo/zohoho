module Zohoho
  class Contact < ZohoObject
    @@myFields = ["ACCOUNTID", "Contact Owner", "Lead Source", "First Name", "Last Name", "Email", "Title", "Department", "Phone", "Home Phone", "Fax", "Mobile", "Date of Birth", "Assistant", "Asst Phone", "Reports To", "Mailing Street", "Other Street", "Mailing City", "Other City", "Mailing State", "Other State", "Mailing Zip", "Other Zip", "Mailing Country", "Other Country", "Description", "Skype ID", "Salutation", "Email3", "Lead Source Detail", "Registration Status", "Email Opt Out", "Secondary Email", "Website"]

    def initialize(h ={})
      @@myFields.each do |f|
        self[f] = h[f] ||''
      end
    end
  end
end
