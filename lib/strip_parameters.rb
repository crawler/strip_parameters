# frozen_string_literal: true

require "strip_parameters/stripper"

# Registers before_action filter to strip parameters
module StripParameters
  extend ActiveSupport::Concern

  included do |base|
    base.class_attribute(:strip_parameters_options)
  end

  def strip_parameters
    Stripper.strip(params, **strip_parameters_options)
  end

  class_methods do
    def strip_parameters(**options)
      Stripper.validate_options(options)
      self.strip_parameters_options = options.slice(*%i[allow_empty collapse_spaces replace_newlines regex])
      # TODO: unregister previously registered callback if any
      before_action(:strip_parameters, options.slice(*%i[only except if unless]))
    end
  end
end
