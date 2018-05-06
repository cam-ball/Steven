module Steven
  # Commands available to the user set as `owner_id` in config.yml
  module Admin
    extend Discordrb::Commands::CommandContainer

    command :adduser do |event, user_id|
      if event.author.id == CONFIG.owner_id
        event.respond "Please provide a valid user ID" unless user_id
        user_id = user_id.to_i

        event.respond "User already exists" if USERS.user_exists?(user_id)

        new_user = User.new(user_id)
        USERS.add_user(new_user)

        event.respond "User added"
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end

    command :addaction do |event, user_id, action|
      if event.author.id == CONFIG.owner_id
        unless user_id && action
          event.respond "Please provide a valid user ID and action"
        end
        user_id = user_id.to_i
        action = action.to_sym

        USERS.add_action(user_id, action) if user_id && action
        event.respond "Action added"
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end

    command :savedata do |event|
      if event.author.id == CONFIG.owner_id
        USERS.save_user_data
        event.respond "User data file updated"
      else
        event.respond "Only my owner is allowed to run this command"
      end
    end
  end
end
