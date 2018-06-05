require 'yaml'
require 'date'


module Goodboy
  module Commands
    class Release
      def initialize(git: Git.new, date: Date.today, config: Config.new)
        @git = git
        @date = date
        @config = config
      end

      def run!
        # check if `git status` returns "nothing to commit"
        git.ensure_clean!

        # read current change
        previous_release = @git.last_release_tag
        previous_change = Change.parse(@git.read_file(@config.current_change_file, revision: previous_release))

        # read previous change
        current_change = Change.parse(File.read(@config.current_change_file, 'r'))
        # no changes in changelog
        raise NoChangesError if previous_change == current_change

        version_file = VersionFile.new(current_change)

        # put it into change log
        Changelog.read(@config.changelog_file).append(current_change, version: version_file.new_numer, date: @date)

        # bump version
        version_file.bump!

        # add version and changelog to commit, commit & push
        git.commit do |commit|
          commit.add_file(version_file.filename)
          commit.add_file(@config.changelog_file)
          commit.push release_message(
            date: date,
            version: version_file.new_numer
          )
        end
      rescue => e
        git.revert!
        raise
      end
    end
  end
end
