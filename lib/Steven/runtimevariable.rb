module Steven
  class RuntimeVariable

    def initialize
      @runtime_var_file = "#{Dir.pwd}/data/runtime_variables.yml"
      file_contents = YAML.load_file(@runtime_var_file) if File.exist?(@runtime_var_file)

      if file_contents.is_a?(Hash) && !file_contents.empty?
        @vars = file_contents
      else
        seed_data
      end
    end

    def current_counter= (val)
      @vars[:current_counter] = val
      save_configurations
    end

    def current_message_seed
      @vars[:current_message_seed]
    end

    def current_counter
      @vars[:current_counter]
    end

    def downtrodden_user
      @vars[:downtrodden_user]
    end

    def create_message_seed
      @vars[:current_message_seed] = Random.rand(5..10)
      @vars[:current_counter] = 0

      save_configurations
      reload_datafile
    end

    private

    def seed_data
      @vars = {}

      @vars[:current_counter] = 0

      @vars[:current_message_seed] = Random.rand(5..10)
      puts "No configuration file found in #{Dir.pwd}/config/config.yml"
      puts 'Creating file now...'

      puts 'Which user needs a pick-me-up? '
      @vars[:downtrodden_user] = gets.chomp
      @vars[:downtrodden_user] = 221687578997424129 if @vars[:downtrodden_user].empty?

      save_configurations
    end

    def save_configurations
      File.open(@runtime_var_file, 'w') do |f|
        f.write YAML.dump(@vars)
      end
    end

    def reload_datafile
      @runtime_var_file = "#{Dir.pwd}/data/runtime_variables.yml"
      file_contents = YAML.load_file(@runtime_var_file) if File.exist?(@runtime_var_file)

      @vars = file_contents
    end
  end
end
