require 'yaml'
require 'date'


module Goodboy
  module Commands
    class Init
      def initialize(config: Config.new, argv: , **)
        @config = config
        @argv = argv
      end

      def run!
        # check version file
        version_file = VersionFile.new(project_name: project_name)
        raise MisisngVersionFile unless File.exists?(version_file.filename)

        # creates empty entry if not exists
        raise CurrentChangeFileAlreadyExistsError, @config.current_change_file if File.exists? @config.current_change_file
        Change.create(project_name: project_name).write(@config.current_change_file)
      end

      private

      def project_name
        @argv[0] || raise(MissingArgError)
      end
    end
  end
end
