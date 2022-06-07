# frozen_string_literal: true

require "test_helper"

class ConfiguredControllerTest < ActionDispatch::IntegrationTest
  def test_strip_parameters
    post "/configured", params: SAME_PARAMS

    assert_equal("John Doe", controller.params[:name])
    assert_equal("", controller.params[:email])
    assert_equal("text with inner things", controller.params[:message])
  end

  def self.app
    Rails.application
  end
end
