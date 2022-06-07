# frozen_string_literal: true

class ConfiguredController < ApplicationController
  include StripParameters
  strip_parameters(regex: /[0-9]/, replace_newlines: true, collapse_spaces: true, allow_empty: true)

  def create
  end
end # class ConfiguredController
