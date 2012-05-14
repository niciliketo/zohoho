module Zohoho
  class ZohoObject < Hash
    def xmlData
      parse_data
    end

    def data_name
      self.class.to_s.split('::').last.pluralize || ''
    end

    def to_s
      sync_symbols_and_methods
      super
    end
    protected
    def parse_data
      sync_symbols_and_methods
      fl = self.map {|e| Hash['val', zohoizeField(e[0]), 'content', (e[1]||'')]}
      row = Hash['no', '1', 'FL', fl]
      data = Hash['row', row]
      XmlSimple.xml_out(data, :RootName => data_name)
    end
    def zohoizeField(sym)
      r = sym
      #We will onyl mess with ones we know as methods, rely on the right format for any custom fields defined in the hash
      if self.send(sym)
        r=sym.to_s.gsub('_',' ').titleize
      end
      return r
    end
    def sync_symbols_and_methods
      # Wanted to give methods to set common attributes, but also flexibility to set a symbol too
      # We actually iterate the symbols, so this is a chacne to sync the two
      self.map {|e| if (self.send(e[0])) then self[e[0]] = self.send(e[0]) end }
    end
  end
end
