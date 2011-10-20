require "open_graph_helper"

module OpenGraphHelper
  class Railtie < Rails::Railtie
    initializer "open_graph_helper.view_helpers" do
      ActionView::Base.send :include, OpenGraphHelper
    end
  end
end