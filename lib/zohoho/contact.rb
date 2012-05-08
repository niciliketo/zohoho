module Zohoho
  class Contact < ZohoObject
    @@myFields = [:contact_owner, :lead_source, :first_name, :last_name, :email,:title, :department, :phone, :home_phone, :fax, :mobile, :date_of_birth, :assistant, :asst_phone, :reports_to, :mailing_street, :other_street, :mailing_city, :other_city, :mailing_state, :other_state, :mailing_zip, :other_zip, :mailing_country, :description, :skype_ID, :salutation, :email3, :lead_source_detail, :registration_tatus, :email_opt_out, :secondary_email]

    def initialize(h ={})
      @@myFields.each do |f|
        self[f] = h[f] ||'123'
      end
    end

    protected
    def zohoizeField(sym)
      if sym == :date_of_birth
        r = "Date of Birth"
      elsif sym == :skype_id
        r = "Skype ID"
      elsif sym == :email_opt_out
        r = "e-Mail Opt out"
      else
        r = super
      end
      r
    end
  end
end
