module Steven
  # Replies to mentions
  module Reply_To_Mention
    require_relative 'config'
    extend Discordrb::EventContainer

    message do |event|
      if event.content.include?(CONFIG.client_id)
        user = event.author
        event.respond("#{user.mention} WADUP WADUP WADUP")
      end
    end
  end
end
  