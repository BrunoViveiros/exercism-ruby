class Tournament
  class << self
    def tally(input)
      parse_input(input)
    end

    private

    def parse_input(input)
      @new_game = Games.new

      games_data = input.split("\n")

      games_data.each do |game|
        first_team, second_team, result = game.split(';')
        @new_game.calculate_score(first_team, second_team, result)
      end

      tally_header + tally_content
    end

    def tally_header
      "#{'Team'.ljust(31)}| MP |  W |  D |  L |  P\n"
    end

    def tally_content
      all_teams = @new_game.teams.sort_by { |team| [-team.calculate_points, team.name] }

      all_teams.map do |team|
        team_name = team.name.to_s.ljust(30)

        "#{team_name}#{format_tally_items(team.matches_played)}#{format_tally_items(team.wins)}#{format_tally_items(team.draws)}#{format_tally_items(team.loses)}#{format_tally_items(team.calculate_points)}\n"
      end.join
    end

    def format_tally_items(item)
      " | #{item.to_s.rjust(2)}"
    end
  end
end

class Team
  attr_reader :name, :wins, :loses, :draws, :calculate_

  def initialize(name)
    @name = name
    @wins = 0
    @loses = 0
    @draws = 0
  end

  def wins_game
    @wins += 1
  end

  def loses_game
    @loses += 1
  end

  def draws_game
    @draws += 1
  end

  def matches_played
    @wins + @loses + @draws
  end

  def calculate_points
    (@wins * 3) + @draws
  end
end

class Games
  attr_reader :teams

  def initialize
    @teams = []
  end

  def calculate_score(first_team, second_team, result)
    case result
    when 'win'
      find_team_name(first_team).wins_game
      find_team_name(second_team).loses_game
    when 'loss'
      find_team_name(first_team).loses_game
      find_team_name(second_team).wins_game
    when 'draw'
      find_team_name(first_team).draws_game
      find_team_name(second_team).draws_game
    end
  end

  def find_team_name(name)
    selected_team = @teams.find { |team| team.name == name }
    selected_team || create_new_team(name)
  end

  def create_new_team(name)
    new_team = Team.new(name)
    @teams << new_team
    new_team
  end
end
