# frozen_string_literal: true

require "test_helper"

class DefaultsControllerTest < ActionDispatch::IntegrationTest
  def test_strip_parameters
    post "/defaults", params: SAME_PARAMS

    assert_equal("John Doe", controller.params[:name])
    assert_nil(controller.params[:email])
    assert_equal("text    \nwith inner things 2", controller.params[:message])
  end

  def self.app
    Rails.application
  end
end
