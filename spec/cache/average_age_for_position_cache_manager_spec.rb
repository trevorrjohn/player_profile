require 'rails_helper'

describe AverageAgeForPositionCacheManager do
  describe '.fetch' do
    before do
      allow(NHL).to receive(:average_age_for_position)
    end

    context 'with no cache saved' do
      it 'gets the result from the model' do
        Rails.cache.delete 'NHL::average_age_for_position::C'

        AverageAgeForPositionCacheManager.fetch NHL, 'C'

        expect(NHL).to have_received(:average_age_for_position).with('C')
      end
    end

    context 'when there is a cache hit' do
      it 'does not interact with the model' do
        Rails.cache.write('NHL::average_age_for_position::C', 34)

        result = AverageAgeForPositionCacheManager.fetch NHL, 'C'

        expect(result).to eq 34
        expect(NHL).not_to have_received(:average_age_for_position)
      end
    end
  end
end
