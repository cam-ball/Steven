module Steven
  # Commands available to the user set as `owner_id` in config.yml
  module Admin
    extend Discordrb::Commands::CommandContainer
    command :addaction do |event, user_id, action|
      if event.author.id == CONFIG.owner_id
        unless user_id && action
          event.respond "Please provide a valid user ID and action"
        end

        user_id = user_id.to_i
        action = action.to_sym

        unless USER_MANAGEMENT.user_exists?(user_id)
          USER_MANAGEMENT.add_user(User.new(user_id))
        end

        event.respond USER_MANAGEMENT.add_action(user_id, action)
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
  end
end
