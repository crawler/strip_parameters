# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"
require_relative "support/stripped_app/config/environment"
require "rails/test_help"
tests_path = Pathname.new(__dir__)
$LOAD_PATH.push(tests_path.to_s)
require "debug"

SAME_PARAMS = {name: " John Doe\r\n", email: "\r\n   \n", message: "text    \nwith inner things 2"}
