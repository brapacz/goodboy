module Goodboy
  UnknownCommandError = Class.new(StandardError) do
    def initialize(command_name)
      super "missing command #{command_name}"
    end
  end

  MissingCommandError = Class.new(StandardError)
  MissingArgError = Class.new(StandardError)
  NoChangesError = Class.new(StandardError)
  CurrentChangeFileAlreadyExistsError = Class.new(StandardError)
  CurrentChangeFileNotExistsError = Class.new(StandardError)
end
