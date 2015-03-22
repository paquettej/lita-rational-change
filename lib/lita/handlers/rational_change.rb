module Lita
  module Handlers
    class RationalChange < Handler
      
      route %r{(\S{0,3}#\d+)}, :build_cr_link

      attr_accessor  :base_url
      
      def self.default_config(config)
        self.base_url = config.base_url
      end
            
      # build a link to ratus1 here
      def build_cr_link(response)
        cr = response.matches.first.first
        url = self.base_url + CGI::escape(cr)
        response.reply(render_template('cr', locals: {cr: cr, url: url}))
#        response.reply("CR #{cr} can be viewed at #{url}")
      end
      
    end

    Lita.register_handler(RationalChange)
  end
end
