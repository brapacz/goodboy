require 'gem_release'

module Goodboy
  class VersionFile < GemRelease::VersionFile
    def initialize(**options)
      @project_name = options[:project_name] # Optionally override project name.
      @content = options[:content] # Option to not read from actual file on disk.
      puts "project_name: #{@project_name.inspect}"
      super(options)
    end

    def gem_name
      @project_name || super
    end
  end
end
