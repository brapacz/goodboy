require 'open3'
require 'ostruct'

module Goodboy
  class Shell
    def exec!(cmd)
      status = exec(cmd)
      raise ShellError, "Failed with exit status #{status.exit_status}" unless status.exit_status == 0
      status
    end

    def exec(cmd)
      Open3.popen3(cmd) do |_stdin, stdout, stderr, wait_thr|
        status = wait_thr.value # Process::Status object returned.
        wrap_result(status, stdout, stderr)
      end
    end

    private

    def wrap_result(status, stdout, stderr)
      OpenStruct.new(exit_status: status.exitstatus, stdout: stdout.read, stderr: stderr.read)
    end
  end
end
