require 'rails_jquery_autocomplete/autocomplete'

module RailsJQueryAutocomplete
end

class ActionController::Base
  include RailsJQueryAutocomplete::Autocomplete
end

