module Zohoho
  class Contact < ZohoObject
    @@myFields = []

    def initialize(h ={})
      @@myFields.each do |f|
        self[f] = h[f] ||''
      end
    end
  end
end
