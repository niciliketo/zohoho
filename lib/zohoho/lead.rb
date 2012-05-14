module Zohoho
  class Lead < ZohoObject
    @@myFields = [:company, :first_name, :last_name, :designation, :email, :phone, :fax, :mobile, :website, :lead_source, :lead_status, :industry, :no_of_employees, :annual_revenue, :email_opt_out, :skype_id, :salutation, :street, :city, :state, :zip_code, :country, :description, :annual_revenue, :rating, :industry_md]
   attr_accessor *@@myFields

    def initialize(h={})
      @@myFields.each do |f|
        self[f] = h[f] ||''
        end
    end
    protected
    def zohoizeField(sym)
      if sym == :no_of_employees
        r = "No of Employees"
      elsif sym == :skype_id
        r = "Skype ID"
      else
        r = super(sym)
      end
      puts r
      r
    end
  end
end
