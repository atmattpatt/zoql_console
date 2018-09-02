# frozen_string_literal: true

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

Then "the console should still be running" do
  expect(PTY.check(@console_pid)).to be_nil, "Process is not running"

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
