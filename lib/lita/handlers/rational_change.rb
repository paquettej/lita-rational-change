module Lita
  module Handlers
    class RationalChange < Handler
      route %r{(\S{0,3}#\d+4)}, :build_cr_link
      
      # build a link to ratus1 here
      def build_cr_link(response)
        url = "http://10.2.241.182:8600/change/PTweb?ACTION_FLAG=frameset_form&TEMPLATE_FLAG=ProblemReportView&database=%2Fcm%2Fccmdb%2Feverest&role=User&problem_number="
        cr = response.matches.first.first
        url += CGI::escape(cr)
        response.reply("CR #{cr} can be viewed at #{url}")
      end
      
    end

    Lita.register_handler(RationalChange)
  end
end
