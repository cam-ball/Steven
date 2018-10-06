module Steven
  # Responds negatively to mesasges from users with the :haze configuration
  module Hazer
    extend Discordrb::EventContainer

    @hazes = YAML.load_file("#{Dir.pwd}/data/hazes.yml")

    message do |event|
      author_id = event.author.id

      user = USER_LIST.find_user_by_id(author_id)

      if user
        if user.action_exists?(:haze)
          user.increment_haze

          if user.trigger_haze?
            user.reset_action(:haze)
            event.respond @hazes.sample
          end
        end
      end
    end
  end
end
