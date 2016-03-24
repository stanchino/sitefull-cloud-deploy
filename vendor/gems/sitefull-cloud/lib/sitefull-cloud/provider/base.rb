module Sitefull
  module Provider
    module Base
      def regions
        []
      end

      def machine_types(*_args)
        []
      end

      def images(*_args)
        []
      end

      def valid?
        false
      end
    end
  end
end
