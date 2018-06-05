module Goodboy
  UnknownCommandError = Class.new(StandardError) do
    def initialize(command_name)
      super "missing command #{command_name}"
    end
  end

  MissingCommandError = Class.new(StandardError)
  NoChangesError = Class.new(StandardError)
end
