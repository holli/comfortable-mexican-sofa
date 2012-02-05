module Cms
  module Fixture

    class PageGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      argument :domain, :type => :string
      argument :page_slug, :type => :string
      argument :page_options, :type => :hash, :default => {}


      def create_page_files

        if (site = Cms::Site.find_site(domain))
          if first_page = site.pages.where(:parent_id => nil).first
            page_options["parent"] ||= first_page.slug
          end
          page_options["layout"] ||= site.layouts.first.identifier
          page_options["is_published"] ||= "true"
        end

        fixtures_path = ComfortableMexicanSofa.config.fixtures_path
        dir = "#{fixtures_path}/#{domain}/pages/"
        dir += (page_options["parent"] + "/") if page_options["parent"]
        dir += page_slug
        
        create_file "#{dir}/_#{page_slug}.yml", <<-File
---
label: "#{page_options["label"]}"
parent: "#{page_options["parent"]}"
layout: "#{page_options["main"]}"
is_published: "#{page_options["is_published"]}"
target_page: "#{page_options["target_page"]}"
        File

        content_file = "#{dir}/content"
        create_file content_file, "Find me in #{content_file}"

      end


    end


  end
end


