module Zohoho 
  require 'httparty'
  require 'json'
  
  class Connection
    include HTTParty
    
    def initialize(service_name, username, password, apikey, zoho_uri = 'https://crm.zoho.com/crm/private/json')
      @service_name, @username, @password, @apikey, @zoho_uri = service_name, username, password, apikey, zoho_uri
    end 
    
    def ticket_url
      "https://accounts.zoho.com/login?servicename=Zoho#{@service_name}&FROM_AGENT=true&LOGIN_ID=#{@username}&PASSWORD=#{@password}"
    end 
    
    def api_key
      @api_key
    end 
    
    def zoho_uri
      @zoho_uri
    end
    
    def ticket
      return @ticket if @ticket
      url = ticket_url 
      ticket_info = self.class.post(url).parsed_response 
      ticket_info.match(/\sTICKET=(.*)\s/)[1]
    end 
    
    def call(entry, api_method, query = {}, http_method = :get)
      login = {
        :apikey => api_key,
        :ticket => ticket
      }    
      query.merge!(login)

     url = [zoho_uri, entry, api_method].join('/')
     case http_method
      when :get       
        raw = JSON.parse(self.class.get(url, :query => query).parsed_response)
        parse_raw(raw, entry)    
      when :post
        JSON.parse(self.class.post(url, :body => query).parsed_response)
      else
        raise "#{http_method} is not a recognized http method"
      end      
    end 
    
    private
    
    def parse_raw(raw, entry)
      return [] if raw['response']['result'].nil?
      rows = raw['response']['result'][entry]['row'] 
      rows = [rows] unless rows.class == Array
      rows.map {|i|
        raw_to_hash i['FL']
      }
    end

    def raw_to_hash(raw)
      raw.map! {|r| [r['val'], r['content']]}
      Hash[raw]
    end
    
  end 
end