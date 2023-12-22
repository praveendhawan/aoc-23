# frozen_string_literal: true

# Main class
class ResultRunnerPart1
  def initialize(file_path)
    @file_path = file_path
  end

  def run
    games = GamesParser.new(@file_path).parse
    game_ids = games.select(&:possible?).map(&:game_id)

    puts game_ids.sum
  end
end

# Parses the input
class GamesParser
  GAME_SEPARATOR = "\n"
  def initialize(file_path)
    @game_results = File.read(file_path)
  end

  def parse
    @game_results.split(GAME_SEPARATOR).map do |game|
      GameParser.new(game).parse
    end
  end
end

# Game Parser
class GameParser
  GAME_ID_REGEX = /Game (\d+):/.freeze

  def initialize(game_string)
    @game_string = game_string
  end

  def parse
    extract_game_id
    parse_sets

    Game.new(@game_id, @sets)
  end

  private

  def extract_game_id
  @game_id = @game_string.match(GAME_ID_REGEX)[1].to_i
  end

  def parse_sets
    @sets = GameSetParser.new(@game_string.sub(GAME_ID_REGEX, '')).parse
  end
end

# Game class
class Game
  def initialize(game_id, sets)
    @game_id = game_id
    @sets = sets
  end

  attr_reader :game_id

  def possible?
    @sets.all?(&:possible?)
  end
end

# parses games set
class GameSetParser
  SET_SEPARATOR = ';'

  def initialize(set_string)
    @set_string = set_string
  end

  def parse
    @set_string.split(SET_SEPARATOR).map do |set|
      GameSet.new(set)
    end
  end
end

# Gameset class
class GameSet
  VALID_COLORS = %w[red green blue].freeze
  COMBINATION = {
    red: 12,
    blue: 14,
    green: 13
  }.freeze

  def initialize(set_string)
    @balls = Hash.new(0)
    parse_set(set_string)
  end

  def possible?
    @balls.all? { |color, count| count <= COMBINATION[color] }
  end

  private

  def parse_set(set_string)
    set_string.split(',').map(&:strip).map do |balls|
      count, color = balls.split(' ')
      next unless valid_color?(color)

      @balls[color.to_sym] += count.to_i
    end
  end

  def valid_color?(color)
    VALID_COLORS.include?(color)
  end
end

ResultRunnerPart1.new('data/day2_p1.txt').run
