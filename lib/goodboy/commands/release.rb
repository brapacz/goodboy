require 'yaml'
require 'date'


module Goodboy
  module Commands
    class Release
      def initialize(git: Git.new, date: Date.today, config: Config.new, **)
        @git = git
        @date = date
        @config = config
      end

      def run!
        # check if `git status` returns "nothing to commit"
        @git.ensure_clean!

        # read previous change
        raise CurrentChangeFileNotExistsError unless File.exists? @config.current_change_file
        current_change = Change.read_file(@config.current_change_file)

        # read current change
        previous_release_tag = @git.last_release_tag

        previous_change = Change.read_stream(@git.read_file(@config.current_change_file, revision: previous_release_tag))
        # no changes in changelog
        raise NoChangesError if previous_change == current_change

        version_file = current_change.build_version_file

        # put it into change log
        Changelog.read(@config.changelog_file).append(current_change, version: version_file.new_numer, date: @date)

        # bump version
        version_file.bump!

        # add version and changelog to commit, commit & push
        @git.add_file!(version_file.filename)
        @git.add_file!(@config.changelog_file)
        @git.commit! release_message(
          date: date,
          version: version_file.new_numer
        )
        @git.push!
      rescue => e
        @git.reset! unless Git::NotCleanError
        raise
      end
    end
  end
end
