module Zohoho
  require 'httparty'
  require 'json'
  require 'xmlsimple'
  require 'date'

  class Crm
    include HTTParty

    def initialize(_host, auth_token, sandbox = false)
      @conn = Zohoho::Connection.new('CRM', auth_token, sandbox)
    end

    def contact_with_name(name)
      first_name, last_name = parse_name(name)
      contacts = find_contacts_by_last_name(last_name)
      contacts.select! do |c|
        c['First Name'] = '' if c['First Name'].nil?
        first_name.match(c['First Name'])
      end
      contacts.first
    end

    def contact_with_id(id)
      find_contact_by_id(id).first
    end

    def contact_with_email(email)
      contacts = find_contacts_by_email(email)
      contacts.first
    end

    def account_with_id(id)
      find_account_by_id(id).first
    end

    def account_with_name(name)
      accounts = find_accounts_by_name(name)
      accounts.first
    end

    def lead_with_name(name)
      first_name, last_name = parse_name(name)
      leads = find_leads_by_last_name(last_name)
      leads.select! do |l|
        l['First Name'] = '' if l['First Name'].nil?
        first_name.match(l['First Name'])
      end
      leads.first
    end

    def add_object(z_object, params = {})
      data = { xmlData: z_object.xmlData, newFormat: 1, wfTrigger: 'true' }
      data.merge!(params) if params.instance_of? Hash
      record = @conn.call(z_object.data_name, 'insertRecords', data, :post)
      record['Id']
    end

    def update_object(id, z_object, params = {})
      data = { id: id, xmlData: z_object.xmlData, newFormat: 1,
               wfTrigger: 'true' }
      data.merge!(params) if params.instance_of? Hash
      record = @conn.call(z_object.data_name, 'updateRecords', data, :post)
      record['Id']
    end

    def add_contact(name)
      first_name, last_name = parse_name(name)
      xmlData = parse_data({ 'First Name' => first_name, 'Last Name' => last_name }, 'Contacts')
      record = @conn.call('Contacts', 'insertRecords', { xmlData: xmlData, newFormat: 1 }, :post)
      record['Id']
    end

    def post_note(entity_id, note_title, note_content)
      xmlData = parse_data({ 'entityId' => entity_id, 'Note Title' => note_title, 'Note Content' => note_content }, 'Notes')
      record = @conn.call('Notes', 'insertRecords', { xmlData: xmlData, newFormat: 1 }, :post)
      record['Id']
    end

    def sales_order(id)
      @conn.call('SalesOrders', 'getRecordById', id: id).first
    end

    def sales_orders(last_modified = nil)
      query = last_modified ? { lastModifiedTime: last_modified.iso8601 } : {}
      @conn.call('SalesOrders', 'getRecords', query)
    end

    def tasks(last_modified = nil)
      query = last_modified ? { lastModifiedTime: last_modified.iso8601 } : {}
      @conn.call('Tasks', 'getRecords', query)
    end

    def tasks_by_due_date(due_date)
      date_str = due_date ? due_date.strftime('%Y-%m-%d') : ''
      query = "(Due Date|is|#{date_str})"
      @conn.call('Tasks', 'getSearchRecords', searchCondition: query, selectColumns: 'All')
    end

    def call(*params)
      @conn.call(*params)
    end

    private

    def parse_name(name)
      match_data = name.match(/\s(\S*)$/)
      last_name = match_data.nil? ? name : match_data[1]

      match_data = name.match(/^(.*)\s/)
      first_name = match_data.nil? ? '' : match_data[1]

      [first_name, last_name]
    end

    def parse_data(data, entry)
      fl = data.map { |e| Hash['val', e[0], 'content', e[1]] }
      row = Hash['no', '1', 'FL', fl]
      data = Hash['row', row]
      XmlSimple.xml_out(data, RootName: entry)
    end

    def find_contacts_by_last_name(last_name)
      search_condition = "(Contact Name|ends with|#{last_name})"
      @conn.call('Contacts', 'getSearchRecords', searchCondition: search_condition, selectColumns: 'All')
    end

    def find_contacts_by_email(email)
      search_condition = "(Email|ends with|#{email})"
      @conn.call('Contacts', 'getSearchRecords', searchCondition: search_condition, selectColumns: 'All')
    end

    def find_contact_by_id(id)
      @conn.call('Contacts', 'getRecordById', id: id, selectColumns: 'All')
    end

    def find_leads_by_last_name(last_name)
      search_condition = "(Lead Name|ends with|#{last_name})"
      @conn.call('Leads', 'getSearchRecords', searchCondition: search_condition, selectColumns: 'All')
    end

    def find_accounts_by_name(name)
      search_condition = "(Account Name|ends with|#{name})"
      @conn.call('Accounts', 'getSearchRecords', searchCondition: search_condition, selectColumns: 'All')
    end

    def find_account_by_id(id)
      @conn.call('Accounts', 'getRecordById', id: id, selectColumns: 'All')
    end
  end
end
