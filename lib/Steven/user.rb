module Steven
  # User class containing all data for any individual configured by owner
  class User
    attr_accessor :actions, :server_id, :user_id, :username, :nicnkname

    ALLOWED_ACTIONS = %i[affirm haze].freeze

    def initialize(params = {})
      @user_id = params[:user_id]
      @username = params[:username]
      @nickname = params[:nickname]
      @server_id = params[:server_id]
      @actions = []
    end

    def complete?
      @user_id && @username && @server_id
    end

    def action_list_s
      @actions.join(", ")
    end

    def add_action(action)
      action = action.to_sym

      unless ALLOWED_ACTIONS.include?(action)
        return "Requested action '#{action}' not defined"
      end

      unless action_exists?(action)
        @actions << action
        initialize_action(action)
      end

      "Action added"
    end

    def increment_affirmation
      @affirmation_counter += 1
    end

    def trigger_affirmation?
      @affirmation_counter == @affirmation_trigger
    end

    def increment_haze
      @haze_counter += 1
    end

    def trigger_haze?
      @haze_counter == @haze_trigger
    end

    def reset_action(action)
      action = action.to_sym

      unless ALLOWED_ACTIONS.include?(action) && action_exists?(action)
        return "Requested action '#{action}' not defined"
      end

      initialize_action(action)
    end

    def action_exists?(action)
      @actions.include?(action)
    end

    def messages_until?(action)
      return unless action_exists?(action)

      case action
      when :affirm
        @affirmation_trigger - @affirmation_counter
      when :haze
        @haze_trigger - @haze_counter
      end
    end

    private

    def initialize_action(action)
      case action
      when :affirm
        @affirmation_counter = 0
        @affirmation_trigger = random_trigger
      when :haze
        @haze_counter = 0
        @haze_trigger = random_trigger
      end
    end

    def random_trigger
      Random.rand(10..30)
    end
  end
end
