require 'rails_helper'
Dir[Rails.root.join('lib/tasks/**/*.rb')].each { |f| require f }

module TaskSupport
  describe Importer do
    it 'instantiates a new SportFetcher' do
      allow(Importer::SportFetcher).to receive :new
      Importer.new 'league'
      expect(Importer::SportFetcher).to have_received(:new)
    end

    it 'instantiates a new deserializer' do
      allow(Importer::Deserializer).to receive :new
      Importer.new 'league'
      expect(Importer::Deserializer).to have_received(:new)
    end

    it 'instantiates a new connection with the proper host' do
      allow(Faraday).to receive :new
      Importer.new 'league'
      expect(Faraday).to have_received(:new).with('http://api.cbssports.com')
    end

    describe '#import' do
      before do
        allow(Player).to receive :create

        @sport_fetcher = instance_double Importer::SportFetcher, find: 'sport'
        @conn = instance_double Faraday::Connection
        @deserializer = instance_double Importer::Deserializer

        @subject = Importer.new('league', @conn, @sport_fetcher, @deserializer)
      end

      it 'uses the league to find the sport' do
        allow(@conn).to receive(:get).and_return(double body: nil)

        @subject.import

        expect(@sport_fetcher).to have_received(:find).with('league')
      end

      it 'fetches makes an API request' do
        allow(@conn).to receive(:get).and_return(double body: nil)


        @subject.import

        path = 'fantasy/players/list?version=3.0&response_format=JSON&SPORT=sport'
        expect(@conn).to have_received(:get)
          .with(path)
      end

      it 'deserializes the json' do
        allow(@deserializer).to receive(:perform).and_return(true)
        response_body = {
          'body' => {
            'players' => [
              {
                'id' => "1992779",
                'firstname' => "Quincy",
                'lastname' => "Acy",
                'position' => "SF",
                'age' => 24,
              }
            ]
          }
        }
        response = instance_double Faraday::Response, body: response_body.to_json
        allow(@conn).to receive(:get).and_return(response)

        @subject.import

        expect(@deserializer).to have_received(:perform).with('league', response_body['body']['players'])
      end

      it 'bulk creates the Player records' do
        response = instance_double Faraday::Response, body: '{"body":{"players":[]}}'
        allow(@conn).to receive(:get).and_return(response)
        deserialized_players = double :deserialized_players
        allow(@deserializer).to receive(:perform).and_return(deserialized_players)

        @subject.import

        expect(Player).to have_received(:create).with(deserialized_players)
      end
    end

    describe Importer::SportFetcher do
      describe '#find' do
        subject { Importer::SportFetcher.new.find(league) }

        context 'when NHL' do
          let(:league) { 'NHL' }
          it { is_expected.to eq 'hockey' }
        end

        context 'when NFL' do
          let(:league) { 'NFL' }
          it { is_expected.to eq 'football' }
        end

        context 'when NBA' do
          let(:league) { 'NBA' }
          it { is_expected.to eq 'basketball' }
        end

        context 'when MLB' do
          let(:league) { 'MLB' }
          it { is_expected.to eq 'baseball' }
        end
      end
    end

    describe Importer::Deserializer do
      describe '#perform' do
        subject { Importer::Deserializer.new.perform('league', json) }

        context 'with proper JSON' do
          let(:json) do
            [
              {
                'id' => "id",
                'firstname' => "Pavel",
                'lastname' => "Datsyuk",
                'position' => "C",
                'age' => 37,
              }
            ]
          end

          it 'returns the Player model object hash' do
            expect(subject).to eq([
              {
                public_id: 'id',
                first_name: 'Pavel',
                last_name: 'Datsyuk',
                position: 'C',
                age: 37,
                type: 'league'
              }
            ])
          end
        end
      end
    end
  end
end

