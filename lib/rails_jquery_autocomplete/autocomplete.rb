module RailsJQueryAutocomplete
  module Autocomplete
    def self.included(target)
      target.extend RailsJQueryAutocomplete::Autocomplete::ClassMethods
    end

    module ClassMethods
      def autocomplete(object, method)
        respond_to :json

        define_method :where_clause do |term|
          ["#{method} LIKE ?", term + "%"]
        end

        define_method :autocomplete_items do |term|
          object.to_s.camelize.constantize.where(where_clause(term))
        end

        define_method :item_hash do |term|
          hash = autocomplete_items(term).inject([]) do |m, e|
            m << {id: e.id, value: e.send(method), label: e.send(method)}
          end
        end

        define_method :items_to_json do |term|
          item_hash(term).to_json
        end

        define_method :show do
          respond_with items_to_json(params[:term])
        end
      end
    end
  end
end
