# encoding: utf-8
#
# Redmine plugin to show all files as file icons or thumbnails
#
# Copyright © 2018 Stephan Wenzel <stephan.wenzel@drwpatent.de>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

require 'mimemagic'
require 'mimemagic/overlay'

module RedmineAllThumbnails
  module Patches 
    module ThumbnailPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do

          unloadable    

          # Generates a thumbnail for the source image to target
          def self.generate_with_svg(source, target, size)

            mime_type = ""
            File.open(source) {|f| mime_type = MimeMagic.by_magic(f).try(:type) }
            extn = MimeMagic::EXTENSIONS.invert[mime_type]

            if extn == "pdf"
              if (Setting['plugin_redmine_all_thumbnails']['pdf_icons'].to_i == 0)
                return generate_without_svg(source, target, size) 
              end
            end 

            if extn =~ /bmp|gif|jpg|jpe|jpeg|png/
              if (Setting['plugin_redmine_all_thumbnails']['image_icons'].to_i == 0)
                return generate_without_svg(source, target, size) 
              end
            end 

            case Setting['plugin_redmine_all_thumbnails']['use_icon_set']
              when "Icons-Vivid"
                icon_set = ICONS_VIVID
                icon_dir = "vivid"
              when "Icons-Square-O"
                icon_set = ICONS_SQUARE_O
                icon_dir = "square-o"
              when "Icons-Classic"
                icon_set = ICONS_CLASSIC
                icon_dir = "classic"
              else
                icon_set = ICONS_CLASSIC
                icon_dir = "classic"
            end 
            
            if icon_set.include? extn
              thumb_filepath = File.join(Rails.root, "public", "plugin_assets", "redmine_all_thumbnails", "images", "icons", icon_dir, "#{extn}.svg")
            else
              # No icon for the attachment was found
              thumb_filepath = File.join(Rails.root, "public", "plugin_assets", "redmine_all_thumbnails", "images", "icons", icon_dir, "blank.svg" )
            end #if

            if Setting['plugin_redmine_all_thumbnails']['use_svg'].to_i != 0
              return thumb_filepath
            end #if
            
            unless convert_available?
              Rails.logger.info "convert not available"
              return nil 
            end

            unless File.exists?(target)
              directory = File.dirname(target)
              unless File.exists?(directory)
                FileUtils.mkdir_p directory
              end
              size_option = "#{size}x#{size}>"
              cmd = "#{shell_quote REDMINE_ALL_THUMBNAILS_CONVERT_BIN} #{shell_quote thumb_filepath} -thumbnail #{shell_quote size_option} #{shell_quote target}"

              unless system(cmd)
                logger.error("Creating thumbnail failed (#{$?}):\nCommand: #{cmd}")
                return nil
              end #unless
            end #unless
            
            target
          end #def 
        
          self.singleton_class.send(:alias_method_chain, :generate, :svg)
                             
        end #base
      end #self

      module InstanceMethods     
      end #module
            
    end #module
  end #module
end #module

unless Redmine::Thumbnail.included_modules.include?(RedmineAllThumbnails::Patches::ThumbnailPatch)
    Redmine::Thumbnail.send(:include, RedmineAllThumbnails::Patches::ThumbnailPatch)
end


