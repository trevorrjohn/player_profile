require_relative 'task_support/importer.rb'

namespace :data do
  desc 'imports data from CBS fantasy player API from NHL, NFL and MLB'
  task import: :environment do
    %w|NHL NFL MLB|.each do |league|
      TaskSupport::Importer.new(league).import
    end
  end
end
