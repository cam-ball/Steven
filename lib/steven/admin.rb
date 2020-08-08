module Steven
  # Commands available to the user set as `owner_id` in config.yml
  module Admin
    extend Discordrb::Commands::CommandContainer
    command(:addaction, description: I18n.t('addaction.description')) do |event, action, *user_info|
      authorize_admin(event) do
        user_info = user_info.join(" ")
        unless user_info && action
          event.respond "Please provide a valid user name or ID and action"
        end
        action = action.to_sym

        discord_user = UserManager.lookup_user_by_server_id(user_info, event.server.id)

        if discord_user.size > 1
          event.respond 'Username is not unique, try using an ID'
        elsif discord_user.size.zero?
          event.respond 'User cannot be found on this server'
        else
          user = discord_user.first
          new_user = User.new(
            server_id: event.server.id,
            user_id: user.id,
            username: user.username,
            nickname: user.nickname,
          )

          event.respond UserManager.add_user_and_action(new_user, action)
        end
      end
    end

    command(:removeaction, description: I18n.t('removeaction.description')) do |event, action, *user_info|
      authorize_admin(event) do
        user_info = user_info.join(" ")
        unless user_info && action
          event.respond "Please provide a valid user name or ID and action"
        end
        action = action.to_sym
        server_id = event.server.id

        discord_users = UserManager.lookup_user_by_server_id(user_info, server_id)

        if discord_users.size > 1
          event.respond 'Username is not unique, try using an ID'
        elsif discord_users.size.zero?
          event.respond 'User cannot be found on this server'
        else
          discord_user_id = discord_users.first.id
          user = USER_LIST.find_user_by_id_and_server(discord_user_id, server_id)

          event.respond user.remove_action(action)
        end
      end
    end

    command(:savedata, description: I18n.t('savedata.description')) do |event|
      authorize_admin(event) do
        USER_LIST.save_user_data
        event.respond "User file updated"
      end
    end

    def self.authorize_admin(event)
      if event.author.id == CONFIG.owner_id
        yield
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end
  end
end
