module Goodboy
  class << self
    def run(command, *argv, **options)
      CommandHandler.new.handle(command, argv: argv, **options)
    end

    def debug?
      %w(1 t y T Y e E).include?(ENV['DEBUG'].to_s[0])
    end

    def debug
      yield if debug?
    end
  end
end
