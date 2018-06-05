module Goodboy
  class CommandHandler
    def handle(command_name, config: Config.new)
      find_command!(command_name).new(config: config).run!
    end

    private

    def find_command!(command_name)
      raise MissingCommandError unless command_name
      command_klass_sufix = command_name.split('_').map(&:capitalize!).join
      command_klass_name = "Goodboy::Commands::#{command_klass_sufix}"
      raise(UnknownCommandError, command_name) unless Kernel.const_defined?(command_klass_name)
      Kernel.const_get(command_klass_name)
    end
  end
end
