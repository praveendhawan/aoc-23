# frozen_string_literal: true

require_relative './base/runner'
require 'matrix'
require 'byebug'

# Engine
class Engine
  NUMBER_REGEX = /\d/.freeze
  SPECIAL_CHAR_REGEX = %r/[!@#$%^&*()_+\-=\[\]{};':"\\|,<>\/?]/.freeze

  def initialize(engine_schema)
    @schema = engine_schema
    @matrix = Matrix[*@schema.split("\n").map(&:chars)]
    @parts = []
  end

  def parts_sum
    parse_schema
    # puts @parts
    @parts.sum
  end

  private

  attr_reader :schema, :matrix, :parts

  def parse_schema
    @part_number = ''
    @valid_part = false
    @matrix.each_with_index do |value, row_index, col_index|
      parse_part(value, row_index, col_index)
    end
  end

  def parse_part(value, row_index, col_index)
    if number?(value)
      @part_number += value
      @valid_part ||= check_adjacent(row_index, col_index)
    else
      @parts << @part_number.to_i if @valid_part && @part_number.length >= 1
      reset_part
    end
  end

  def reset_part
    @part_number = ''
    @valid_part = false
  end

  def number?(value)
    NUMBER_REGEX.match?(value)
  end

  def special_char?(value)
    SPECIAL_CHAR_REGEX.match?(value)
  end

  def period?(value)
    value == '.'
  end

  def check_adjacent(row_index, col_index)
    adjacent_indices(row_index, col_index).any? do |row, col|
      special_char?(matrix[row, col])
    end
  end

  def adjacent_indices(row_index, col_index)
    [
      [row_index - 1, col_index - 1],
      [row_index - 1, col_index],
      [row_index - 1, col_index + 1],
      [row_index, col_index - 1],
      [row_index, col_index + 1],
      [row_index + 1, col_index - 1],
      [row_index + 1, col_index],
      [row_index + 1, col_index + 1]
    ]
  end
end

# Day 3 Runner
class Day3Runner < Base::Runner
  def run
    puts 'Day 3: Part 1'
    puts "Result: #{Engine.new(input).parts_sum}"
  end
end

Day3Runner.new('data/day3_test.txt').run
Day3Runner.new('data/day3_p1.txt').run
