require 'discordrb/webhooks'

module Steven
  # User information display
  class Info
    extend Discordrb::Commands::CommandContainer

    command(:display, description: I18n.t('display.description')) do |event, user_info|
      server_id = event.server.id
      server_users = UserManager.lookup_user_by_server_id(user_info, server_id)

      if server_users.size > 1
        event.respond 'Username is not unique, try using an ID'
      elsif server_users.size.zero?
        event.respond 'User cannot be found on this server'
      else
        server_user = server_users.first
        steven_user = USER_LIST.find_user_by_id_and_server(server_user.id, server_id)

        event.channel.send_embed do |embed|
          embed.title = server_user.nickname || server_user.username
          embed.colour = 0xcfeff4
          embed.timestamp = Time.now

          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: server_user.avatar_url)
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: I18n.t('display.embed.footer'),
            icon_url: BOT.profile.avatar_url,
          )

          embed.add_field(name: 'Username', value: server_user.username)
          embed.add_field(name: 'Configured actions', value: steven_user&.action_list_s || 'None... yet.')

          if steven_user
            embed.add_field(
              name: 'Messages until affirmation',
              value: steven_user.messages_until?(:affirm) || 'N/A',
              inline: true,
            )
            embed.add_field(
              name: "Messages until haze",
              value: steven_user.messages_until?(:haze) || 'N/A',
              inline: true,
            )
          end
        end
      end
    end
  end
end
