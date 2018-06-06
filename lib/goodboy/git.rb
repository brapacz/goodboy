module Goodboy
  class Git
    NotCleanError = Class.new(StandardError)

    def ensure_clean!
      `git status`.include? 'nothing to commit, working tree clean'
    end

    private

  end
end
