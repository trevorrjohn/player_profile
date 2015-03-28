require 'rails_helper'

RSpec.describe NFL, type: :model do
  describe '#name_brief' do
    subject { @player.name_brief }

    context 'with first and last names' do
      before do
        @player = NFL.new first_name: 'Golden', last_name: 'Saltini'
      end

      it { is_expected.to eq 'G Saltini' }
    end

    context 'with only first name' do
      before do
        @player = NFL.new first_name: 'Golden'
      end

      it { is_expected.to eq 'G' }
    end

    context 'with only last name' do
      before do
        @player = NFL.new last_name: 'Saltini'
      end

      it { is_expected.to eq 'Saltini' }
    end

    context 'with neither first nor last name' do
      before do
        @player = NFL.new
      end

      it { is_expected.to be_blank }
    end
  end
end
