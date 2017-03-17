# rubocop: disable Metrics/AbcSize
# https://github.com/activeadmin/activeadmin/blob/master/lib/active_admin/view_helpers/display_helper.rb
#
module ActiveAdmin
  module ViewHelpers
    module DisplayHelper
      def pretty_format_with_pretty_other_format(object)
        pretty_uploader_format(object) ||
          pretty_jsonb_format(object) ||
          pretty_format_without_pretty_other_format(object)
      end
      alias_method_chain :pretty_format, :pretty_other_format

      def pretty_uploader_format(object)
        if object.class.ancestors.include?(CarrierWave::Uploader::Base)
          if object.present?
            if object.version_exists?(:thumb) && object.thumb.file.exists?
              content_tag(:p,
                          image_tag(object.url(:thumb)),
                          class: 'attachment_wrap attachment_img')
            else
              link_to object.file.identifier, object.url
            end
          end
        end
      end

      def pretty_jsonb_format(object)
        if object.class.ancestors.include?(Hash)
          content_tag(:pre,
                      JSON.pretty_generate(object).gsub(':', ' =>'))
        end
      end
    end
  end
end
