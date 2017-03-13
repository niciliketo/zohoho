#!/usr/bin/env ruby
# -------------
# Example: Update fields from CRM
# -------------
# Read a CSV file and update all contacts with temp field

# Load various libraries we need
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib') unless $LOAD_PATH.include?(File.dirname(__FILE__) + '/../lib')
require 'rubygems'
require 'zohoho'
require 'pp'
require 'csv'

# ADD API KEY HERE (but dont commit to github)
crm_auth_token = ''
print 'CRM Auth Token:'
if crm_auth_token.empty?
  puts 'please add crm_auth_token key'
  exit
end
# An empty hask (key&value pairs) to hold our update
# connect to CRM
@crm = Zohoho::Crm.new(crm_auth_token)

# Load the CSV
CSV.foreach('eWorld.csv', :headers => true) do |row|
  # We expect each row to contain several values, which we can access as follows:-
  # row['NAME']
  # row['Company']
  # row['Data tag (Temp field)']
  # row['Zoho Contact ID']

  # We could print them like this:
  # puts "#{row['NAME']}  #{row['Company']} #{row['Data tag (Temp field)']} #{row['Zoho Contact ID']}"

  # Ruby has a special variable to show the line we are processing
  # puts $.

  # Skip any rows where we dont have a contact ID
  next if row['Zoho Contact ID'].nil?

  #puts "#{$.} - #{row['Zoho Contact ID']}"
  # In the file, contact IDs are formatted with leading zcrm_
  # there are lots of ways to do this, including...
  contact_id = row['Zoho Contact ID'].gsub('zcrm_', '')

  if ($.).to_i < 4
    #crm_data = @crm.contact_with_id(contact_id)
    if contact_id.length > 8
    #pp crm_data
    contact = Zohoho::Contact.new
    contact['Temp Field 2'] = row['Data tag (Temp field)']
    @crm.update_object(contact_id, contact)
    pp @crm
    else
      puts "Not attempted, invalid contact id #{contact_id}"
    end
  end
end

# pp @crm.tasks

