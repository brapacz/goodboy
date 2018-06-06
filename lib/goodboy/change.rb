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

    def initialize(project_name:, description: , version: )
      @project_name = project_name
      @description = description
      @version = version
    end


    def write(path)
      File.write(path, dump_params.to_yaml)
    end

    private

    def dump_params
      {
        'project_name' => project_name,
        'version' => version,
        'description' => description,
      }
    end
  end
end
