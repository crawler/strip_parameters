# frozen_string_literal: true

require "strip_parameters/stripper"

# Registers before_action filter and sets configuration options.
module StripParameters
  extend ActiveSupport::Concern

  included do |base|
    base.class_attribute(:strip_parameters_options, default: {})
  end

  private

  # This method can be used in actions without setting up filter.
  # See class method StripParameters.strip_parameters
  def strip_parameters(**options)
    Stripper.strip(params, **strip_parameters_options.merge(options))
  end

  class_methods do
    # Sets configuration options and register strip_parameters filter.
    #
    # @param [Regexp] regex - expression to replace in parametes values.
    # @param [Boolean] replace_newlines - replace newlines with spaces.
    # @param [Boolean] collapse_spaces - replaces multiple spaces with one.
    # @param [Boolean] allow_empty - keeps empty strings.
    #
    # @return [nil]
    #
    def strip_parameters(**options)
      Stripper.validate_options(options)
      self.strip_parameters_options = options.slice(*%i[allow_empty collapse_spaces replace_newlines regex])
      # TODO: unregister previously registered callback if any
      before_action(:strip_parameters, options.slice(*%i[only except if unless]))
    end
  end
end
