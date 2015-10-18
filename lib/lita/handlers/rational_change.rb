module Lita 
  module Handlers 
    class RationalChange < Handler 

      config :base_url, type: String, required: true 
      config :timeout, type: Float, default: 600.0, required: false

      route %r{(\S{0,3}#\d+)}i, :build_cr_link 

      # build a link to ratus1 here 
      def build_cr_link(response) 
        # don't respond to own messages -- why does this happen?
        if response.user.name == Lita.config.robot.name
          Lita.logger.warn "received message from myself, ignoring..."
          return
        end
                  
        visible_crs = load_crs(response.matches.flatten)
        Lita.logger.info("visible_crs count: #{visible_crs.length}")
        
        if visible_crs.any?
          case robot.config.robot.adapter 
          when :slack 
            target = response.message.source.room_object || response.message.source.user 
            urls = format_urls_for_slack(visible_crs)
            robot.chat_service.send_attachment(target, build_attachment(urls.join(',')))
          else 
            response.reply(render_template('cr', cr: visible_crs.first, url: visible_crs.first.url)) 
          end 
          visible_crs.map(&:mentioned!)
        end
      end 

      def format_urls_for_slack(crs)
        links = []
        crs.each do |cr|
          links << format_url(cr)
        end
        links
      end
      
      def format_url(cr) 
        "<#{cr.url}|#{cr.name}>" 
      end       

      def load_crs(cr_list)
        links = []
        cr_list.each do |cr|
          change_request = ChangeRequest.new(cr, redis)
          Lita.logger.info "CR #{change_request.name} mention status #{change_request.mentioned_recently?}"
          links << change_request unless change_request.mentioned_recently?
        end
        links
      end
      
      # build the attachment object for slack
      def build_attachment(text) 
        Lita::Adapters::Slack::Attachment.new(text, 
        { 
          :color => 'danger', 
          :title => 'Recently mentioned defects', 
          :thumb_url => 'http://i.imgur.com/Z5HdCsT.png', 
        }) 
      end 
    end 

    Lita.register_handler(RationalChange) 
  end 
end
