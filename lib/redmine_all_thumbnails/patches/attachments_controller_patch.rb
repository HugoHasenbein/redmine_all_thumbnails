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
    module AttachmentsControllerPatch
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable
          alias_method_chain :thumbnail, :all
          
        end #base
        
      end #self

      module InstanceMethods						

		def thumbnail_with_all
		  if @attachment.thumbnailable? && tbnail = @attachment.thumbnail(:size => params[:size])
			if stale?(:etag => tbnail)
			  #
			  # thumbnail file formats are not necessarily identical to their attachment file formats
			  # anymore - therefore, we must check individually, which file format the thumbnail has
			  #
			  mime_type = ""
			  File.open(tbnail) {|f| mime_type = MimeMagic.by_magic(f).try(:type) }
			  thumbnail_filename   = File.basename(@attachment.filename, File.extname(@attachment.filename))
			  thumbnail_filename  += Rack::Mime::MIME_TYPES.invert[mime_type] 

			  send_file tbnail,
				:filename => filename_for_content_disposition( thumbnail_filename ),
				:type => mime_type,
				:disposition => 'inline'
			end
		  else
			# No thumbnail for the attachment or thumbnail could not be created
			head 404
		  end
		end

      end #module      

      module ClassMethods
      end #def 

    end #module
  end #module
end #module

unless AttachmentsController.included_modules.include?(RedmineAllThumbnails::Patches::AttachmentsControllerPatch)
    AttachmentsController.send(:include, RedmineAllThumbnails::Patches::AttachmentsControllerPatch)
end



