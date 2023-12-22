# frozen_string_literal: true

require_relative './day2_p1'

# Main class
class ResultRunnerPart2
  def initialize(file_path)
    @file_path = file_path
  end

  def run
    games = GamesParser.new(@file_path).parse
    game_powers = games.map(&:power)

    puts game_powers.sum
  end
end

# Game class
class Game
  def power
    return @power if @power

    cubes_required = Hash.new(0)
    @sets.each do |set|
      cubes_required.merge!(set.power) { |_color, old, new| new > old ? new : old }
    end
    @power = cubes_required.values.reduce(:*)
  end
end

# Gameset class
class GameSet
  attr_reader :balls
  alias power balls
end

ResultRunnerPart2.new('data/day2_p1.txt').run
