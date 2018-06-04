module Goodboy
  MissingCommandError = Class.new(StandardError) do
    def initialize(command_name)
      super "missing command #{command_name}"
    end
  end
end
