require 'rails_helper'

describe Initialer do
  class TestInitialer
    include Initialer

    attr_accessor :first_name, :last_name
  end

  describe '#first_initial' do
    before do
      @test_initialer = TestInitialer.new
    end

    subject { @test_initialer.first_initial }

    context 'with no first name' do
      before do
        @test_initialer.first_name = nil
      end

      it { is_expected.to be_nil }
    end

    context 'with empty first name' do
      before do
        @test_initialer.first_name = ''
      end

      it { is_expected.to be_nil }
    end

    context 'with first name' do
      before do
        @test_initialer.first_name = 'Sammy'
      end

      it { is_expected.to eq 'S.' }
    end
  end

  describe '#last_initial' do
    before do
      @test_initialer = TestInitialer.new
    end

    subject { @test_initialer.last_initial }

    context 'with no last name' do
      before do
        @test_initialer.last_name = nil
      end

      it { is_expected.to be_nil }
    end

    context 'with empty last name' do
      before do
        @test_initialer.last_name = ''
      end

      it { is_expected.to be_nil }
    end

    context 'with last name' do
      before do
        @test_initialer.last_name = 'Sammy'
      end

      it { is_expected.to eq 'S.' }
    end
  end
end
