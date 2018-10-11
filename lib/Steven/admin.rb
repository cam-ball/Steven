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

        if user_info.to_i.positive?
          user_id = user_info.to_i
          username = lookup_by_user_id(event.server.id, user_id)
        else
          username = user_info
          user_id = lookup_by_username(event.server.id, username)

          user_id = user_id.first unless user_id.size > 1
        end

        if username && user_id.is_a?(Integer)
          USER_MANAGEMENT.add_user(User.new(user_id, username))
          event.respond USER_MANAGEMENT.add_action(user_id, action)
        elsif username.nil? || user_id.nil?
          event.respond 'User cannot be found on this server'
        else
          event.respond 'Username is not unique, try using an ID'
        end
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end

    command(:savedata, description: 'Manually saves user data to user data file') do |event|
      if event.author.id == CONFIG.owner_id
        USER_MANAGEMENT.save_user_data
        event.respond "User file updated"
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end

    def self.lookup_by_user_id(server_id, user_id)
      BOT.servers[server_id].users.select { |u| u.id == user_id }.first&.username
    end

    def self.lookup_by_username(server_id, username)
      matching_usernames = BOT.servers[server_id].users.select do |u|
        u.username == username || u.nickname == username
      end

      matching_usernames.map(&:id)
    end
  end
end
