module Goodboy
  class Config
    DEFAULT_CHANGES_FILE = '.last_change.yml'
    DEFAULT_CHANGELOG_FILE = 'CHANGELOG.md'

    attr_reader :changes_file, :changelog_file

    def initialize(changes_file = DEFAULT_CHANGES_FILE, changelog_file: DEFAULT_CHANGELOG_FILE)
      @changelog_file = changelog_file
      @changes_file = changes_file
    end
  end
end
