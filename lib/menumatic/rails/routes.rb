module ActionDispatch::Routing
  class Mapper
    def sitemap_for(navigation)
      self.match 'sitemap.xml'=> 'menumatic/sitemap#index', :format => :xml, :navigation_id => navigation
    end
  end
end
