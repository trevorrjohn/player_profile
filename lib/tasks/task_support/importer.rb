module TaskSupport
  class Importer
    HOST = 'http://api.cbssports.com'.freeze
    PATH = 'fantasy/players/list?version=3.0&response_format=JSON&SPORT='

    def initialize(
      league,
      conn=Faraday.new(HOST),
      sport_fetcher=SportFetcher.new,
      deserializer=Deserializer.new
    )
      @league = league
      @conn = conn
      @sport_fetcher = sport_fetcher
      @deserializer = deserializer
    end

    def import
      json = json_response
      return unless json

      deserialized_players = deserializer.perform(league, json['body']['players'])
      Player.create(deserialized_players)
    end

    class Deserializer
      def perform(league, players_json)
        players_json.collect do |player|
          {
            public_id: player['id'],
            first_name: player['firstname'],
            last_name: player['lastname'],
            position: player['position'],
            age: player['age'],
            type: league
          }
        end
      end
    end

    class SportFetcher
      SPORT = {
        'NHL' => 'hockey',
        'NBA' => 'basketball',
        'NFL' => 'football',
        'MLB' => 'baseball',
      }.freeze

      def find(league)
        SPORT[league]
      end
    end

    private

    attr_reader :league, :conn, :sport_fetcher, :deserializer

    def json_response
      body = raw_response.body
      JSON.parse(body) if body
    end

    def raw_response
      conn.get path
    end

    def path
      [PATH, sport].join ''
    end

    def sport
      sport_fetcher.find(league)
    end
  end
end
