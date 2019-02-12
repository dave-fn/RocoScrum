# frozen_string_literal: true

namespace :db do
  desc 'Start Postgres DB server, no logging'
  task start: :environment do
    system('pg_ctl -D /usr/local/var/postgres/data start')
    fail if $?.exitstatus.nonzero? # rubocop:disable Style/SpecialGlobalVars
  end

  desc 'Stop Postgres DB server'
  task stop: :environment do
    system('pg_ctl -D /usr/local/var/postgres/data stop -s -m fast')
    fail if $?.exitstatus.nonzero? # rubocop:disable Style/SpecialGlobalVars
  end
end
