module Zohoho
  class ZohoObject < Hash
    def xml_data
      parse_data
    end

    def data_name
      self.class.to_s.split('::').last + 's' || ''
    end


    protected
    def parse_data
      fl = map { |e| Hash['val', (e[0]), 'content', (e[1] || '')] }
      row = Hash['no', '1', 'FL', fl]
      data = Hash['row', row]
      XmlSimple.xml_out(data, :RootName => data_name)
    end
  end
end
