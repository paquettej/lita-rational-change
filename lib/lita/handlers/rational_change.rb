module Lita
  module Handlers
    class RationalChange < Handler
      route %r{(.{0,3}#\d+4)} :build_cr_link
      
      # build a link to ratus1 here
      def build_cr_link(response)
        response.reply(response.matches)
      end
      
    end

    Lita.register_handler(RationalChange)
  end
end
