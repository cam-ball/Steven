module Steven
  # Wrapper for response events
  # - lookup user and sever information from cached user data
  # - increment appropriate counters
  # - trigger response and reset counter, if threshold is reached
  class Responder
    def self.call(event, action, responses)
      author_id = event.author.id
      server_id = event.server.id

      user = USER_LIST.find_user_by_id_and_server(author_id, server_id)

      return unless user&.action_permitted?(action)

      user.increment(action)

      return unless user.trigger?(action)

      user.reset_action(action)
      event.respond responses.sample
    end
  end
end
