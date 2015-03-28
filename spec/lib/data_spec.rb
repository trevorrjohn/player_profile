require 'rails_helper'
require 'rake'
Dir[Rails.root.join('lib/tasks/**/*.rb')].each { |f| require f }

describe 'Data' do
  before do
    load File.expand_path("../../../lib/tasks/data.rake", __FILE__)
    Rake::Task.define_task(:environment)
    allow(Rails.cache).to receive(:clear)
  end

  describe '#import' do
    it 'instantiates the importer for the NBA, NHL, NFL and MLB' do
      importer = instance_double TaskSupport::Importer, import: true
      allow(TaskSupport::Importer).to receive(:new).and_return(importer)

      Rake::Task['data:import'].invoke

      expect(TaskSupport::Importer).to have_received(:new).with('NHL')
      expect(TaskSupport::Importer).to have_received(:new).with('NBA')
      expect(TaskSupport::Importer).to have_received(:new).with('NFL')
      expect(TaskSupport::Importer).to have_received(:new).with('MLB')
    end

    it 'imports each league' do
      importer1 = instance_double TaskSupport::Importer, 'importer1', import: true
      importer2 = instance_double TaskSupport::Importer, 'importer2', import: true
      importer3 = instance_double TaskSupport::Importer, 'importer3', import: true
      importer4 = instance_double TaskSupport::Importer, 'importer1', import: true

      allow(TaskSupport::Importer).to receive(:new).and_return(importer1, importer2, importer3, importer4)

      Rake::Task['data:import'].invoke

      expect(importer1).to have_received :import
      expect(importer2).to have_received :import
      expect(importer3).to have_received :import
      expect(importer4).to have_received :import
    end

    it 'clears the cache' do
      allow(TaskSupport::Importer).to receive(:new).and_return(instance_double TaskSupport::Importer, import: true)

      Rake::Task['data:import'].invoke

      expect(Rails.cache).to have_received(:clear)
    end

    after do
      task = Rake::Task['data:import']
      task.reenable
      task.clear
    end
  end
end
