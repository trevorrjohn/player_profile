require 'rails_helper'

RSpec.describe Player, type: :model do
  shared_examples_for 'average age by position' do |klass|
    subject { klass.average_age_for_position 'C' }

    context 'when no players' do
      it { is_expected.to be_nil }
    end

    context 'when no players with that position' do
      it { is_expected.to be_nil }
    end

    context 'with players at the position' do
      before do
        trait = klass.name.downcase.to_sym
        other_trait = ([:nba, :nfl, :nhl, :mlb] - [trait]).sample

        FactoryGirl.create :player, trait, age: 5, position: 'C'
        FactoryGirl.create :player, trait, age: 15, position: 'C'
        FactoryGirl.create :player, trait, age: 100, position: 'P'
        FactoryGirl.create :player, other_trait, age: 100, position: 'C'
      end

      it 'averages the age' do
        expect(subject).to eq 10
      end
    end
  end

  it_behaves_like 'average age by position', MLB
  it_behaves_like 'average age by position', NHL
  it_behaves_like 'average age by position', NBA
  it_behaves_like 'average age by position', NFL
end
