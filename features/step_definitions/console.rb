# frozen_string_literal: true

# Run the zoql program
#
# @param args [Array] command line args
def run_zoql(args = [])
  @read_pipe, @write_pipe = IO.pipe
  @parent_io, @child_file = PTY.open

  @console_pid = Process.spawn(
    console_command,
    *args,
    err: @child_file,
    in: @read_pipe,
    out: @child_file,
    unsetenv_others: true,
  )

  @read_pipe.close
  @child_file.close
end

# Kill the console process if it is still running
def kill_console_if_running
  sleep 0.1
  Process.kill("KILL", @console_pid) if PTY.check(@console_pid).nil?
rescue Errno::ESRCH
  # Do nothing
end

Given "a running console" do
  run_zoql
end

When "I run zoql with {string}" do |args|
  run_zoql(args.split)
end

When "I send command {string}" do |command|
  @write_pipe.puts(command)
  @write_pipe.close
end

When "I send a null byte" do
  @write_pipe.puts("\0")
  @write_pipe.close
end

When "I signal {string}" do |signal|
  sleep 0.1
  Process.kill(signal, @console_pid)
end

Then "the console should still be running" do
  expect(PTY.check(@console_pid)).to be_nil, "Process is not running"
  kill_console_if_running
  @console_output = @parent_io.read
end

Then "the console should exit" do
  @console_output = @parent_io.read

  _, @console_status = Process.wait2(@console_pid)
  expect(@console_status).not_to be_nil, "Process did not exit"
end

Then "the exit status should be {int}" do |expected|
  expect(@console_status.exitstatus).to eq(expected), \
    "Expected exit status to be #{expected} but it was #{@console_status.exitstatus}\n\n" \
    "Output:\n#{@console_output}\n\n"
end

Then "the output should contain {string}" do |expected|
  expect(@console_output).to include(expected)
end

Then "the output should match {string}" do |expected|
  regexp = Regexp.new(expected)
  expect(@console_output).to match(regexp)
end
