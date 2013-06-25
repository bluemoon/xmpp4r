# =XMPP4R - XMPP Library for Ruby
# License:: Ruby's license (see the LICENSE file) or GNU GPL, at your option.
# Website::http://home.gna.org/xmpp4r/

require 'xmpp4r/xmppstanza'
require 'xmpp4r/x'

module Jabber
  ##
  # The Message class manages the <message/> stanzas,
  # which is used for all messaging communication.
  class MGMessage < XMPPStanza

    CHAT_STATES = %w(active composing gone inactive paused).freeze

    name_xmlns 'message', 'jabber:client'
    force_xmlns true

    include XParent

    ##
    # Create a new message
    # >to:: a JID or a String object to send the message to.
    # >payload:: the message's body
    def initialize(to = nil, payload = nil)
      super()
      if not to.nil?
        set_to(to)
      end
      if !body.nil?
        add_element(REXML::Element.new("payload").add_text(body))
      end
    end

    ##
    # Get the type of the Message stanza
    #
    # The following Symbols are allowed:
    # * :chat
    # * :error
    # * :groupchat
    # * :headline
    # * :normal
    # result:: [Symbol] or nil
    def type
      case super
        when 'mg_chat_publish' then :mg_chat_publish
        else nil
      end
    end

    ##
    # Set the type of the Message stanza (see Message#type for details)
    # v:: [Symbol] or nil
    def type=(v)
      case v
        when :chat then super('chat')
        when :error then super('error')
        when :groupchat then super('groupchat')
        when :headline then super('headline')
        when :normal then super('normal')
        else super(nil)
      end
    end

    ##
    # Set the type of the Message stanza (chaining-friendly)
    # v:: [Symbol] or nil
    def set_type(v)
      self.type = v
      self
    end

    ##
    # Returns the message's body, or nil.
    # This is the message's plain-text content.
    def body
      first_element_text('body')
    end

    ##
    # Sets the message's body
    #
    # b:: [String] body to set
    def body=(b)
      replace_element_text('body', b)
    end

    ##
    # Sets the message's body
    #
    # b:: [String] body to set
    # return:: [REXML::Element] self for chaining
    def set_body(b)
      self.body = b
      self
    end
  end
end
