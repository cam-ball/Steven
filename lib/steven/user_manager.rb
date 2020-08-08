module Steven
  # Wrapper class for general user management
  class UserManager
    attr_reader :users

    def initialize(user_data_path = nil)
      @users = []
      @user_data_file = user_data_path || "#{Dir.pwd}/data/user_data.yml"

      file_contents = YAML.load_file(@user_data_file) if File.exist?(@user_data_file)

      return unless file_contents.is_a?(Array) && !file_contents.empty?

      @users = file_contents
    end

    def add_user(user)
      return if find_user_by_id_and_server(user.user_id, user.server_id)

      @users << user
    end

    def find_user_by_id_and_server(user_id, server_id)
      @users.select do |user|
        user.user_id == user_id && user.server_id == server_id
      end.first
    end

    def add_action(new_user, action)
      user = find_user_by_id_and_server(new_user.user_id, new_user.server_id)

      return unless user

      user.add_action(action)
    end

    def save_user_data
      File.open(@user_data_file, 'w') do |f|
        f.write YAML.dump(@users)
      end
    end

    def self.lookup_user_by_server_id(user_info, server_id)
      users = BOT.servers[server_id].users.select { |u| u.id == user_info.to_i }

      # if a user with a matching ID exists return, otherwise
      # check if the integer provided actually the username or nickname
      return users unless users.empty?

      BOT.servers[server_id].users.select do |u|
        [u.username, u.nickname].include?(user_info)
      end
    end

    def self.add_user_and_action(new_user, action)
      return 'Invalid User' unless new_user.complete?

      USER_LIST.add_user(new_user)
      USER_LIST.add_action(new_user, action)
    end

    private

    attr_writer :users
  end
end
