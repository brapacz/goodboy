module Goodboy
  class CommandHandler
    def handle(command_name)
      self.class.find_command!(command_name).new.run!
    end

    class << self
      def register(handler_klass)
        commands_registry << handler_klass
      end

      def find_command!(command_name)
        find_command(command_name) || raise(MissingCommandError, command_name)
      end

      def find_command(command_name)
        commands_registry.find { |klass| klass.command_name == command_name }
      end

      private

      def commands_registry
        @commands_registry ||= []
      end
    end

    private
  end
end
