module Zohoho
  class ZohoObject < Hash
    def xmlData
      parse_data
    end

    def data_name
      #self.class.to_s.split('::').last.pluralize || '' - not without RoR, and s should be enough
      self.class.to_s.split('::').last + "s" || ''
    end

    protected

    def parse_data
      fl = self.map { |e| Hash['val', (e[0]), 'content', (e[1]||'')] }
      row = Hash['no', '1', 'FL', fl]
      data = Hash['row', row]
      XmlSimple.xml_out(data, RootName: data_name)
    end
  end
end
