# frozen_string_literal: true

# Monkey Patch / Hack
module JSONAPI

  class LinkBuilder

    private

    def formatted_module_path_from_class(klass)
      scopes = module_scopes_from_class(klass)

      unless scopes.empty?
        # "/#{scopes.map(&:underscore).join('/')}/".gsub(/api\/v[0-9]+\//, 'api/')
        "/#{scopes.map(&:underscore).join('/')}/".gsub(%r<api/v[0-9]+/>, 'api/')
      else
        '/'
      end
    end

  end

end
