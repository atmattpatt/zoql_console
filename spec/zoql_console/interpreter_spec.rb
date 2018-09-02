# frozen_string_literal: true

RSpec.describe ZoqlConsole::Interpreter do
  describe "#command" do
    ['\?'].each do |input|
      it "can handle '#{input}'" do
        subject.buffer = input
        expect(subject.command).not_to be_nil
      end
    end

    it "outputs an error message for unknown commands" do
      subject.buffer = "boom"

      expect do
        expect(subject.command).to be_nil
      end.to output("Unknown command: boom\n").to_stdout
    end
  end

  describe "blank?" do
    it "is false when a command is given" do
      subject.buffer = '\?'
      expect(subject).not_to be_blank
    end

    it "is true when only whitespace is given" do
      subject.buffer = "   "
      expect(subject).to be_blank
    end

    it "is true when the buffer is empty" do
      subject.buffer = ""
      expect(subject).to be_blank
    end
  end

  describe "#exit?" do
    it 'is true for "\q"' do
      subject.buffer = '\q'
      expect(subject).to be_exit
    end

    it "is true for 'exit'" do
      subject.buffer = "exit"
      expect(subject).to be_exit
    end

    it "is false for other values" do
      subject.buffer = '\?'
      expect(subject).not_to be_exit
    end
  end
end
