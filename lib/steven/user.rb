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
      return if @actions.empty?

      @actions.join(", ")
    end

    def add_action(action)
      action = action.to_sym

      unless ALLOWED_ACTIONS.include?(action)
        return "Requested action '#{action}' not defined"
      end

      unless action_permitted?(action)
        @actions << action
        initialize_action(action)
      end

      "Action added"
    end

    def remove_action(action)
      action = action.to_sym

      unless ALLOWED_ACTIONS.include?(action)
        return "Requested action '#{action}' not defined"
      end

      if action_permitted?(action)
        @actions.delete(action)
        remove_instance_variable(counter(action))
        remove_instance_variable(trigger(action))
      end

      "Action removed"
    end

    def increment(action)
      val = instance_variable_get(counter(action)) || 0
      instance_variable_set(counter(action), val + 1)
    end

    def trigger?(action)
      instance_variable_get(counter(action)) ==
        instance_variable_get(trigger(action))
    end

    def reset_action(action)
      unless ALLOWED_ACTIONS.include?(action) && action_permitted?(action)
        return "Requested action '#{action}' not defined"
      end

      initialize_action(action)
    end

    def action_permitted?(action)
      @actions.include?(action)
    end

    def messages_until?(action)
      return unless action_permitted?(action)

      instance_variable_get(trigger(action)) -
        instance_variable_get(counter(action))
    end

    private

    def initialize_action(action)
      instance_variable_set(counter(action), 0)
      instance_variable_set(trigger(action), random_trigger)
    end

    def counter(action)
      "@#{action}_counter"
    end

    def trigger(action)
      "@#{action}_trigger"
    end

    def random_trigger
      Random.rand(30..50)
    end
  end
end
