# frozen_string_literal: true

NUM_MAP = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
  'zero' => '0'
}.freeze

REGEXP = /(#{NUM_MAP.keys.join('|')}|\d)/.freeze

lines = File.read('data/day1_p1.txt')

# lines = "two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen"

# lines = "three28jxdmlqfmc619eightwol\n"

calibration_value =
  lines.split("\n").reduce(0) do |res, line|
    first_match = line.match(REGEXP).to_s
    first = NUM_MAP[first_match] || first_match
    last_match = line.rpartition(REGEXP)[1]
    last = NUM_MAP[last_match.to_s] || last_match
    res + (first + last).to_i
  end

puts calibration_value
