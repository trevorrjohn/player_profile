require_relative 'task_support/importer.rb'

namespace :data do
  desc 'imports data from CBS fantasy player API from NBA, NHL, NFL and MLB'
  task import: :environment do
    %w|NBA NHL NFL MLB|.each do |league|
      TaskSupport::Importer.new(league).import
    end
    Rails.cache.clear
  end
end
