# frozen_string_literal: true

module Discordrb::EventContainer
  attr_reader :event_handlers
end

module DiscordHelper
  def dispatch(klass, event)
    allow(event).to receive(:"is_a?").with(klass).and_return(true)
    Steven::BOT.event_handlers[klass].each do |handler|
      handler.match(event)
    end
  end

  def message_event(content:, author_id: 1, server_id: 1)
    double("event",
      content: content,
      channel: double("channel", "private?": false),
      server: double("server", id: server_id, resolve_id: server_id),
      author: double("author", id: author_id, resolve_id: author_id),
      timestamp: double("timestamp")
    )
  end
end
