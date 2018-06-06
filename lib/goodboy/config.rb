module Goodboy
  class Config
    DEFAULT_CHANGES_FILE = '.last_change.yml'
    DEFAULT_CHANGELOG_FILE = 'CHANGELOG.md'

    attr_reader :current_change_file, :changelog_file

    def initialize(current_change_file = DEFAULT_CHANGES_FILE, changelog_file: DEFAULT_CHANGELOG_FILE)
      @changelog_file = changelog_file
      @current_change_file = current_change_file
    end
  end
end
