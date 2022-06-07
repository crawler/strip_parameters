# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
# require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StrippedApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.log_level = :debug
    config.root = Pathname.new(__dir__).parent

    # Settings specified here will take precedence over those in config/application.rb.

    # Turn false under Spring and add config.action_view.cache_template_loading = true.
    config.cache_classes = true

    # Eager loading loads your whole application. When running a single test locally,
    # this probably isn't necessary. It's a good idea to do in a continuous integration
    # system, or in some way before deploying your code.
    config.eager_load = ENV["CI"].present?

    # Show full error reports and disable caching.
    config.consider_all_requests_local = true
    config.action_controller.perform_caching = false
    config.cache_store = :null_store

    # Raise exceptions instead of rendering exception templates.
    config.action_dispatch.show_exceptions = false

    # Disable request forgery protection in test environment.
    config.action_controller.allow_forgery_protection = false

    # Print deprecation notices to the stderr.
    config.active_support.deprecation = :stderr

    # Raise exceptions for disallowed deprecations.
    config.active_support.disallowed_deprecation = :raise
  end
end
