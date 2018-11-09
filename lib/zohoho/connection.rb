module Zohoho
  require 'httparty'
  require 'json'

  class Connection
    include HTTParty
    # Next line can help with debugging
    # debug_output $stdout
    attr_reader :auth_token

    def initialize(service_name, auth_token, sandbox)
      @service_name = service_name
      @sandbox = sandbox
      @auth_token = auth_token
    end

    def zoho_uri
      "https://#{@service_name.downcase}#{'sandbox' if @sandbox}.zoho.com"\
      "/#{@service_name.downcase}/private/json"
    end

    def call(entry, api_method, query = {}, http_method = :get)
      query[:authtoken] = @auth_token
      query[:scope] = "#{@service_name.downcase}api"
      url = [zoho_uri, entry, api_method].join('/')
      case http_method
      when :get
        res = self.class.get(url, query: query).parsed_response
        res = res.to_json if res.is_a?(HTTParty::Response) || res.is_a?(Hash)
        raw = JSON.parse(res)
        res = parse_raw_get(raw, entry)
      when :post
        res = self.class.post(url, body: query)
        res = res.to_json if res.is_a?(HTTParty::Response) || res.is_a?(Hash)
        raw = JSON.parse(res)
        res = parse_raw_post(raw)
      else
        raise "#{http_method} is not a recognized http method"
      end
      parse_error(res, query) if (res.class == Hash) && res['error']
      res
    end

    private

    def parse_raw_get(raw, entry)
      if raw['response']['result'].nil?
        return_value =  []
      elsif !raw['response']['error'].nil?
        return_value = raw['response']
      else
        rows = raw['response']['result'][entry]['row']
        rows = [rows] unless rows.class == Array
        return_value = rows.map do |i|
          raw_to_hash i['FL']
        end
      end
      return_value
    end

    def parse_raw_post(raw)
      if !raw['response']['error'].nil?
        return_value = raw['response']
      else
        record = raw['response']['result']['recorddetail']
        return_value = raw_to_hash record['FL']
      end
      return_value
    end

    def parse_error(response, query)
      error = "Zoho returned error code #{response['error']['code']} : "\
              "#{response['error']['message']}.\n" \
              "The query sent to Zoho was: #{query}."
      puts error
      raise error
    end

    def raw_to_hash(raw)
      raw.map! { |r| [r['val'], r['content']] }
      Hash[raw]
    end
  end
end
