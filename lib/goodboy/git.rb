module Goodboy
  class Git
    NotCleanError = Class.new(StandardError)

    VERSION_TAG_REGEX = /v[0-9]+\.[0-9]+\.[0-9]+.*/

    attr_reader :shell

    def initialize(shell = Shell.new)
      @shell = shell
    end

    def ensure_clean!
      shell_exec!('git status').include? 'nothing to commit, working tree clean'
    end

    def last_release_tag
      shell_exec!('git tag').each_line.reverse_each.find{ |tag| tag =~ VERSION_TAG_REGEX }
    end

    def read_file(path, revision: nil)
      revision ||= 'HEAD'
      puts `git status`
      shell_exec! 'git show #{revision}:#{path}'
    end

    private

    def shell_exec!(cmd)
      @shell.exec!(cmd).stdout
    end

  end
end
