module Steven
  # Commands available to the user set as `owner_id` in config.yml
  module Admin
    extend Discordrb::Commands::CommandContainer
    command(:addaction, description: <<-helptext
      Instruct Steven to begin tracking a user
      actions:
        affirm - Steven showers the user with affection
        haze - Steven repremands the user
      user_info can be a user ID or username
      usage:
        `!addaction approve Steven`
      helptext
      ) do |event, action, *user_info|
      user_info = user_info.join(" ")
      if event.author.id == CONFIG.owner_id
        unless user_info && action
          event.respond "Please provide a valid user name or ID and action"
        end
        action = action.to_sym

        users = UserManagement.lookup_user_by_server_id(user_info, event.server.id)

        if users.size > 1
          event.respond 'Username is not unique, try using an ID'
        elsif users.size.zero?
          event.respond 'User cannot be found on this server'
        else
          user = users.first
          new_user = User.new(
            server_id: event.server.id,
            user_id: user.id,
            username: user.username,
            nickname: user.nickname
          )

          event.respond UserManagement.add_user_and_action(new_user, action)
        end
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end

    command(:savedata, description: 'Manually saves user data to user data file') do |event|
      if event.author.id == CONFIG.owner_id
        USER_LIST.save_user_data
        event.respond "User file updated"
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end
  end
end
