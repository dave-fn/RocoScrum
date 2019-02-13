# frozen_string_literal: true

namespace :rubocop do

  task run: :environment do
    system('bundle exec rubocop -f s .')
    fail if $?.exitstatus.nonzero? # rubocop:disable Style/SpecialGlobalVars
  end

  desc 'RuboCop lint checks'
  task lint: :environment do
    system('bundle exec rubocop --lint .')
    fail if $?.exitstatus.nonzero? # rubocop:disable Style/SpecialGlobalVars
  end

  desc 'List counts summary'
  task summary: :environment do
    system('bundle exec rubocop --format o .')
    fail if $?.exitstatus.nonzero? # rubocop:disable Style/SpecialGlobalVars
  end

  desc 'Generate TODO list'
  task todo: :environment do
    system('bundle exec rubocop --auto-gen-config .')
    fail if $?.exitstatus.nonzero? # rubocop:disable Style/SpecialGlobalVars
  end

end

desc 'Run RuboCop in current folder'
task rubocop: 'rubocop:run'
