module Zohoho
  class ZohoObject < Hash
    def xmlData
      parse_data
    end

    def data_name
      self.class.to_s.split('::').last.pluralize || ''
    end

    protected
    def parse_data
      #data = self.inspect
      fl = self.map {|e| Hash['val', zohoizeField(e[0]).titleize, 'content', e[1]]}
      row = Hash['no', '1', 'FL', fl]
      data = Hash['row', row]
      XmlSimple.xml_out(data, :RootName => data_name)
    end
    def zohoizeField(sym)
      sym.to_s.gsub('_',' ').titleize
    end
  end
end
