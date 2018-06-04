require 'yaml'


module Goodboy
  module Commands
    class Bump
      def self.command_name
        name.split('::').last.downcase
      end

      def run!
        # read yaml
        thing = YAML.load_file('test.yml')
      end
    end

    CommandHandler.register(Bump)
  end
end
