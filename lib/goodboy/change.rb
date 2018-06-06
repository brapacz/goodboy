module Goodboy
  class Change
    PATCH = 'patch'
    MINOR = 'minor'
    MAJOR = 'major'
    FIRST_DESCRIPTION = 'Added goodboy gem.'

    attr_reader :project_name, :description, :version

    def self.create(project_name: ,**)
      new project_name: project_name, description: FIRST_DESCRIPTION, version: PATCH
    end

    def initialize(project_name:, description: nil, version: PATCH)
      @project_name = project_name
      @description = description
      @version = version
    end

    def build_version_file
      puts "version_file_path: #{version_file_path}"
      VersionFile.new project_name: project_name, content: File.read(version_file_path)
    end

    def write(path)
      File.write(path, dump_params.to_yaml)
    end

    def self.read_file(path)
      read_stream File.read(path)
    end

    def self.read_stream(stream)
      puts "-----\n#{stream}\n77777\n"
      args = YAML.load(stream)
      symbolized_args = args.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      new symbolized_args
    end

    private

    def version_file_path
      File.join Dir.pwd, 'lib', project_name, 'version.rb'
    end

    def dump_params
      {
        'project_name' => project_name,
        'version' => version,
        'description' => description,
      }
    end
  end
end
