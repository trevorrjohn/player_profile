require 'rails_helper'

RSpec.describe NBA, type: :model do
  describe '#name_brief' do
    subject { @player.name_brief }

    context 'with first and last names' do
      before do
        @player = NBA.new first_name: 'Golden', last_name: 'Saltini'
      end

      it { is_expected.to eq 'Golden S.' }
    end

    context 'with only first name' do
      before do
        @player = NBA.new first_name: 'Golden'
      end

      it { is_expected.to eq 'Golden' }
    end

    context 'with only last name' do
      before do
        @player = NBA.new last_name: 'Saltini'
      end

      it { is_expected.to eq 'S.' }
    end

    context 'with neither first nor last name' do
      before do
        @player = NBA.new
      end

      it { is_expected.to be_blank }
    end
  end
end
