module Hinagiku
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework  :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
