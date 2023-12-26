# frozen_string_literal: true

module Base
  # Runner class
  class Runner
    def initialize(file_path)
      @file_path = file_path
    end

    def run
      raise 'Not implemented'
    end

    private

    def input
      @input ||= File.read(@file_path)
    end
  end
end
