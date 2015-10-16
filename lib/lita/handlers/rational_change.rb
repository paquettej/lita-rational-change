module Lita 
  module Handlers 
    class RationalChange < Handler 

      config :base_url, type: String, required: true 

      route %r{(\S{0,3}#\d+)}i, :build_cr_link 

      # build a link to ratus1 here 
      def build_cr_link(response) 
        # don't respond to own messages -- why does this happen?
        return if response.user.name == Lita.config.robot.name
        
        cr_list = response.matches.flatten 

        body_text = build_links(cr_list) 

        case robot.config.robot.adapter 
        when :slack 
          target = response.message.source.room_object || response.message.source.user 
          robot.chat_service.send_attachment(target, build_attachment(body_text)) 
        else 
          response.reply(render_template('cr', cr: cr, url: url)) 
        end 
      end 

      def build_links(cr_list) 
        cr_list.map{|cr| format_url(cr)}.join(', ') 
      end 

      def format_url(cr) 
        "<#{build_url(cr)}|#{cr}>" 
      end 

      def build_url(cr) 
        config.base_url + CGI::escape(cr) 
      end 

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
