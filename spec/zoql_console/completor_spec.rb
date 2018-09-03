# frozen_string_literal: true

RSpec::Matchers.define :complete do |input|
  match do |completor|
    @actual = completor.complete(input)
    !@actual.nil? && values_match?(@actual.sort, @expected_completions.sort)
  end

  failure_message do |_completor|
    "Expected '#{input}' to complete to ['#{@expected_completions.join("', '")}']"
  end

  chain :with do |*expected_completions|
    @expected_completions = expected_completions.flatten
  end
end

RSpec.describe ZoqlConsole::Completor do
  let(:config) { ZoqlConsole::Config.default }
  subject(:completor) { ZoqlConsole::Completor.new(config: config) }

  describe "console commands" do
    specify { expect(completor).to complete("?").with("?") }
    specify { expect(completor).to complete("co").with("config") }
    specify { expect(completor).to complete("q").with("q") }
  end

  describe "Zuora objects" do
    specify { expect(completor).to complete("Acc").with("Account", "AccountingCode", "AccountingPeriod") }
  end
end
