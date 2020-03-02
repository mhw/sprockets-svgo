module Sprockets
  module SVGO::SassFunctions
    def svgo_data_uri(path, options = {})
      options = options.to_h.map { |k, v| [k.value.to_sym, v.value] }.to_h
      if options[:precision]
        options[:precision] = options[:precision].to_i
      end
      url = sprockets_context.svgo_asset_data_uri(path.value, options)
      Autoload::SassC::Script::Value::String.new("url(" + url + ")")
    end
  end
end

if defined?(SassC::Rails)
  # This module is used by sassc-rails, if loaded
  SassC::Rails::SassTemplate::Functions.send :include, Sprockets::SVGO::SassFunctions
end

# This module is used by sprockets itself, if sassc-rails is not loaded
Sprockets::SasscProcessor::Functions.send :include, Sprockets::SVGO::SassFunctions
