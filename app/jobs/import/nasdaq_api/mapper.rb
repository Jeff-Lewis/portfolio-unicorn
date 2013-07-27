module Import
  module NasdaqApi
    class Mapper
      def initialize(header)
        @mapped_header = header.map {|c| mapping[c] || c }
      end

      def attributes_for(row)
        key_value_array = [@mapped_header, row].transpose
        attributes = Hash[key_value_array]
        attributes.slice(*Security.attribute_names)
      end

      private
        def mapping
          {'Symbol' => 'symbol', 'Name' => 'name'}
        end
    end
  end
end