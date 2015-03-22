module Lita
  module Handlers
    class RationalChange < Handler
      
      config :base_url, type: String, required: true
      
      route %r{(\S{0,3}#\d+)}i, :build_cr_link
            
      # build a link to ratus1 here
      def build_cr_link(response)
        cr = response.matches.first.first
        url = config.base_url + CGI::escape(cr)
        response.reply(render_template('cr', cr: cr, url: url))
      end
      
    end

    Lita.register_handler(RationalChange)
  end
end
