module Steven
  # Commands available to the user set as `owner_id` in config.yml
  module Admin
    extend Discordrb::Commands::CommandContainer
    command :addaction do |event, user_id, action|
      if event.author.id == CONFIG.owner_id
        unless user_id && action
          event.respond "Please provide a valid user ID and action"
        end

        if user_id.to_i > 0
          user_id = user_id.to_i
          username = lookup_by_user_id(event.server.id, user_id)
        else
          username = user_id
          user_id = lookup_by_username(event.server.id, username)
        end

        action = action.to_sym

        if username && user_id
          USER_MANAGEMENT.add_user(User.new(user_id, username))
          event.respond USER_MANAGEMENT.add_action(user_id, action)
        else
          event.respond "User cannot be found on this server"
        end
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end

    command :savedata do |event|
      if event.author.id == CONFIG.owner_id
        USER_MANAGEMENT.save_user_data
        event.respond "User data file updated"
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end

    def self.lookup_by_user_id(server_id, user_id)
      BOT.servers[server_id].users.select{ |u| u.id == user_id }.first&.username
    end

    def self.lookup_by_username(server_id, username)
      matching_usernames = BOT.servers[server_id].users.select{ |u| u.username == username }
      event.respond "Username not unique, please user user id" if matching_usernames.size > 1
      matching_usernames.first&.id
    end
  end
end
