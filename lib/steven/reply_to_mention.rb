module Steven
  # Replies to mentions
  module ReplyToMention
    require_relative 'config'
    extend Discordrb::EventContainer

    message do |event|
      if event.content.include?(CONFIG.client_id)
        user = event.author
        event.respond("You rang, #{user.mention}?")
      end
    end
  end
end
