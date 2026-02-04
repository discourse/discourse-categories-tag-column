# frozen_string_literal: true

module PageObjects
  module Components
    class CategoriesTagColumn < PageObjects::Components::Base
      SELECTOR = ".categories-tag-list"

      def visible?
        has_css?(SELECTOR)
      end

      def has_listed_tag?(tag)
        has_css?("#{SELECTOR} a.discourse-tag[href='#{tag.url}']", text: tag.name)
      end
    end
  end
end
