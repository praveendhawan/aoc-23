# frozen_string_literal: true

lines = File.read('data/day1_p1.txt')

calibration_value =
  lines.split("\n").reduce(0) do |res, line|
    scanned = line.scan(/\d/)
    res + (scanned.first + scanned.last).to_i
  end

puts calibration_value
