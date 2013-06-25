# =XMPP4R - XMPP Library for Ruby
# License:: Ruby's license (see the LICENSE file) or GNU GPL, at your option.
# Website::http://home.gna.org/xmpp4r/

require 'xmpp4r'
require 'xmpp4r/discovery'

module Jabber
  module MGMessage
    ##
    # A Helper to manage service and item discovery.
    class Helper
      def initialize(client)
        @stream = client
      end
      
      def send_message(jid, payload)
        msg = Jabber::MGMessage.new(jid, payload)
        msg.from = @stream.jid

        res = nil

        @stream.send_with_id(msg) { |reply|
          res = reply
        }

        res
      end
    end
  end
end
