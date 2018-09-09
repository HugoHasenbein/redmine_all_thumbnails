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

module RedmineAllThumbnails
  module Patches 
    module ApplicationHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do

          unloadable 
          
          alias_method :thumbnail_tag, :thumbnail_tag_with_class
          
          define_method(:truncate_middle, instance_method(:truncate_middle))
                      
        end #base
      end #self

      module InstanceMethods  
        
		 def thumbnail_tag_with_class(attachment, options={})
		   thumbnail_size = Setting.thumbnails_size.to_i
		   link_to(
			 image_tag(
			   thumbnail_path(attachment),
			   { :class => "thumbnail",
			     :srcset => "#{thumbnail_path(attachment, :size => thumbnail_size * 2)} 2x",
			     :style => "height: #{thumbnail_size}px; width: auto;"
			    }.merge(options)
			 ) + tag(:br) + content_tag(:span, truncate_middle( attachment.filename, 20 ), :style => "width: #{thumbnail_size*2}px;", :class => "thumbnail filename" ),
			 named_attachment_path(
			   attachment,
			   attachment.filename
			 ),
			 :title => attachment.filename
		   ) 
		 end
		 
		 #--------------------------------------------------------------------------------
         def truncate_middle( anystring, length=150 )
  
            return anystring if (length <= 0) || (length > anystring.length) 
            return ""        if anystring.blank? 
            return anystring.first(length/2) + "…" + anystring.last(length/2-1)
     
         end #def

          
      end #module
      
    end #module
  end #module
end #module

unless ApplicationHelper.included_modules.include?(RedmineAllThumbnails::Patches::ApplicationHelperPatch)
    ApplicationHelper.send(:include, RedmineAllThumbnails::Patches::ApplicationHelperPatch)
end


