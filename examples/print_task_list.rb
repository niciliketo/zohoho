# -------------
# Example: Prints out all tasks
# -------------
# Gets all tasks and prints them to the screen.

unless $LOAD_PATH.include?(File.dirname(__FILE__) + '/../lib')
  $LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
end

require 'rubygems'
require 'zohoho'
require 'pp'

USERNAME = 'aisha.fenton'.freeze
PASSWORD = 'epson123'.freeze
ZOHO_KEY = 'wcRImoTaNxWDAgM-LlfsbhRqsC8Zcu03kQaMGWeIdlI$'.freeze

@crm = Zohoho::Crm.new(USERNAME, PASSWORD, ZOHO_KEY)

pp @crm.tasks
