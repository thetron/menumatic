module Menumatic
  module Generators
    class NavigationGenerator < Rails::Generators::Base
      desc "Creates a new navigation file"
      source_root File.expand_path('../templates', __FILE__)
      argument :navigation_name, :type => :string, :default => "application"
      class_option :stylesheet, :type => :boolean, :default => true,  :description => "Include stylesheet file"

      def generate_navigation
        template "navigation.rb", "app/navigation/#{file_name}_navigation.rb"
      end

      def generate_stylesheet
        copy_file "stylesheet.css", "public/stylesheets/#{file_name}_navigation.css" unless options.skip_stylesheet?
      end

      private
      def file_name
        navigation_name.underscore
      end
    end
  end
end
