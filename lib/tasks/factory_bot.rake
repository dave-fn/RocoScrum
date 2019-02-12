# frozen_string_literal: true

# From FactoryBot Getting Started Guide

namespace :factory_bot do
  desc 'Verify that all FactoryBot factories are valid'
  task lint: :environment do
    if Rails.env.test?
      DatabaseCleaner.clean_with :deletion
      DatabaseCleaner.cleaning do
        FactoryBot.lint
      end
    else
      system("bundle exec rake factory_bot:lint RAILS_ENV='test'")
      fail if $?.exitstatus.nonzero? # rubocop:disable Style/SpecialGlobalVars
    end
  end
end
