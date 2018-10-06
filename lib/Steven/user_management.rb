module Steven
  # Wrapper class for general user management
  class UserManagement
    def initialize
      @users = []
      @user_data_file = "#{Dir.pwd}/data/user_data.yml"

      if File.exist?(@user_data_file)
        file_contents = YAML.load_file(@user_data_file)
      end

      return unless file_contents.is_a?(Array) && !file_contents.empty?

      @users = file_contents
    end

    def add_user(user)
      return if user_exists?(user.user_id)
      @users << user
    end

    def find_user_by_id(user_id)
      @users.select { |usr| usr.user_id == user_id }.first
    end

    def find_user_by_username(username)
      @users.select { |usr| usr.username == username }.first
    end

    def add_action(new_user, action)
      user = @users.select { |usr| usr.user_id == new_user.user_id }.first

      return unless user

      user.add_action(action)
    end

    def user_exists?(user_id)
      @users.select { |usr| usr.user_id == user_id }.any?
    end

    def save_user_data
      File.open(@user_data_file, 'w') do |f|
        f.write YAML.dump(@users)
      end
    end

    def self.lookup_user_by_server_id(user_info, server_id)
      if user_info.to_i.positive?
        BOT.servers[server_id].users.select { |u| u.id == user_info.to_i }
      else
        BOT.servers[server_id].users.select do |u|
          u.username == user_info || u.nickname == user_info
        end
      end
    end

    def self.add_user_and_action(new_user, action)
      return 'Invalid User' unless new_user.complete?

      USER_LIST.add_user(new_user)
      USER_LIST.add_action(new_user, action)
    end
  end
end
