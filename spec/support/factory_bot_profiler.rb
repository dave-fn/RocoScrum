# frozen_string_literal: true

## from https://www.eliotsykes.com/profiling-factorygirl
class FactoryBotProfiler

  attr_accessor :results

  # rubocop:disable EmptyLinesAroundModuleBody
  module Constants
    NOTIFICATION_NAME = 'factory_bot.run_factory'
    MONITOR_RECORD_CREATION_SYMBOL = :monitor_database_record_creation
  end
  # rubocop:enable EmptyLinesAroundModuleBody

  def self.setup
    profiler = new

    RSpec.configure do |config|
      config.before(:suite) { profiler.subscribe }
      config.after(:suite) { profiler.dump }
    end
  end

  def initialize
    self.results = {}
  end

  def subscribe
    ActiveSupport::Notifications.subscribe(Constants::NOTIFICATION_NAME) do |_name, start, finish, _id, payload|
      factory, strategy = payload.values_at(:name, :strategy)

      factory_result = results[factory] ||= {}
      strategy_result = factory_result[strategy] ||= { duration_in_secs: 0.0, count: 0 }

      duration_in_secs = finish - start
      strategy_result[:duration_in_secs] += duration_in_secs
      strategy_result[:count] += 1
    end
  end

  def dump
    puts "\nFactoryBot Profiles"
    total_in_secs = 0.0
    results.each do |factory_name, factory_profile|
      puts "\n  #{factory_name}"
      factory_profile.each do |strategy, profile|
        puts "    #{strategy} called #{profile[:count]} times took #{profile[:duration_in_secs].round(2)} seconds total"
        total_in_secs += profile[:duration_in_secs]
      end
    end
    puts "\n Total FactoryBot time #{total_in_secs.round(2)} seconds"
  end

  # based on https://thoughtbot.com/blog/debugging-why-your-specs-have-slowed-down
  def self.monitor_database_record_creation
    RSpec.configure do |config|
      config.before(:each, Constants::MONITOR_RECORD_CREATION_SYMBOL) do |_example|
        ActiveSupport::Notifications.subscribe(Constants::NOTIFICATION_NAME) do |_name, _start, _finish, _id, payload|
          warn "FactoryBot: #{payload[:strategy]}(:#{payload[:name]})"
        end
      end

      config.after(:each, Constants::MONITOR_RECORD_CREATION_SYMBOL) do |_example|
        ActiveSupport::Notifications.unsubscribe(Constants::NOTIFICATION_NAME)
      end
    end
  end

end
