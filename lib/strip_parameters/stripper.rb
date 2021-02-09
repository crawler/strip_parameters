# frozen_string_literal: true

module StripParameters
  # Singleton that performs the strip work
  class Stripper
    # :only and an :except options are for the actions filtering, not paratmeters
    VALID_OPTIONS = %i[only except if unless allow_empty collapse_spaces replace_newlines regex].freeze

    # Unicode invisible and whitespace characters. The POSIX character class
    # [:space:] corresponds to the Unicode class Z ("separator"). We also
    # include the following characters from Unicode class C ("control"), which
    # are spaces or invisible characters that make no sense at the start or end
    # of a string:
    #   U+180E MONGOLIAN VOWEL SEPARATOR
    #   U+200B ZERO WIDTH SPACE
    #   U+200C ZERO WIDTH NON-JOINER
    #   U+200D ZERO WIDTH JOINER
    #   U+2060 WORD JOINER
    #   U+FEFF ZERO WIDTH NO-BREAK SPACE
    MULTIBYTE_WHITE = "\u180E\u200B\u200C\u200D\u2060\uFEFF"
    MULTIBYTE_SPACE = /[[:space:]#{MULTIBYTE_WHITE}]/.freeze
    MULTIBYTE_SPACE_REGEX = /\A#{MULTIBYTE_SPACE}+|#{MULTIBYTE_SPACE}+\z/.freeze
    MULTIBYTE_BLANK = /[[:blank:]#{MULTIBYTE_WHITE}]/.freeze
    MULTIBYTE_BLANK_REGEX = /#{MULTIBYTE_BLANK}+/.freeze

    def self.strip(paramters, **options)
      paramters.transform_values! do |value|
        if value.is_a?(ActionController::Parameters)
          strip(value, **options)
        else
          next value if !value.is_a?(String) || value.frozen?

          process_string(value, **options)
        end
      end
    end

    def self.process_string(value, regex: nil, replace_newlines: false, collapse_spaces: false, allow_empty: false)
      strip_string(value)
      value.gsub!(regex, '') if regex
      value.gsub!(/[\r\n]+/, ' ') if replace_newlines
      collapse_inner_string_spaces(value) if collapse_spaces

      value if value != '' || allow_empty
    end

    def self.strip_string(value)
      if Encoding.compatible?(value, MULTIBYTE_SPACE)
        value.gsub!(MULTIBYTE_SPACE_REGEX, '') # TODO: ensure that the regexp match only outer spaces
      else
        value.strip!
      end
    end

    def self.collapse_inner_string_spaces(value)
      if Encoding.compatible?(value, MULTIBYTE_BLANK)
        value.gsub!(MULTIBYTE_BLANK_REGEX, ' ')
      else
        value.squeeze!(' ')
      end
    end

    def self.validate_options(options)
      keys = options.keys
      return unless (keys - VALID_OPTIONS).any?

      raise ArgumentError, "Unexpected options #{options.keys.inspect}. Valid options are #{VALID_OPTIONS}"
    end
  end
end
