# encoding: utf-8
#
# Redmine plugin to show all files as file icons or thumnails
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
            
          alias_method_chain   :thumbnail, :icon

        end #base
        
      end #self

      module InstanceMethods

		  ICONS_CLASSIC = %w(3g2 3ga 3gp 7z aa aac accdb accdt adn ai aif aifc aiff ait 
							 amr ani apk app asax ascx asf ash ashx asmx asp aspx asx au 
							 aup avi axd aze bash bat bin blank bmp bpg browser bz2 c cab 
							 caf cal cd cer class cmd com compile config cpp cr2 crt 
							 crypt cs csh csproj css csv cue dat db dbf deb dgn dist dll 
							 dmg dng doc docb docm docx dot dotm dotx dpj ds_store dtd 
							 dwg dxf eot eps epub exe f4v fax fb2 fla flac flv folder 
							 gadget gem gif gitignore go gpg gz h htm html ibooks ico ics
							 idx iff image img indd inf ini iso jar java jpe jpeg jpg js 
							 json jsp jsx key kf8 ksh less licx lit log lua m2v m3u m3u8 
							 m4a m4r m4v map master md mdb mdf mid midi mkv mobi mov mp2 
							 mp3 mp4 mpa mpd mpe mpeg mpg mpga mpp mpt msi msu nef nes 
							 odb ods odt ogg ogv ost otf ott ovf p12 p7b pages part pcd 
							 pdb pdf pem pfx pgp ph phar php pl pm png po pot potx pps 
							 ppsx ppt pptm pptx prop ps psd psp pst pub py qt ra ram rar 
							 raw rb rdf resx rm rpm rsa rtf rub sass scss sdf sh sitemap 
							 skin sldm sldx sln sql step stl svg swd swf swift sys tar 
							 tcsh tex tga tgz tif tiff torrent ts tsv ttf txt udf vb 
							 vbproj vcd vcs vdi vdx vmdk vob vsd vss vst vsx vtx war wav 
							 wbk webinfo webm webp wma wmf wmv woff woff2 wsf xaml xcf 
							 xlm xls xlsm xlsx xlt xltm xltx xml xpi xps xrb xsd xsl xspf 
							 xz yml z zip zsh).freeze

		 ICONS_SQUARE_O = %w(3g2 3ga 3gp 7z aa aac accdb accdt adn ai aif aifc aiff ait 
							 amr ani apk app asax ascx asf ash ashx asmx asp aspx asx au 
							 aup avi axd aze bak bash bat bin blank bmp bpg browser bz2 
							 c cab caf cal cd cer cmd com compile cpp cr2 crt cs csh 
							 csproj css dat db dbf deb dgn dist dll dmg dng doc docx dot 
							 dotx ds_store dwg dxf eot eps epub exe f4v fb2 fla flac flv 
							 folder gadget gem gif gitignore go gpg gz htm html ibooks 
							 ico ics iff image indd iso jar java jpe jpeg jpg js json 
							 jsp jsx key kf8 ksh less licx lit lock log m2v m3u m3u8 m4a 
							 m4r m4v map master md mdb mdf mid midi mobi mov mp2 mp3 mpa 
							 mpeg mpg mpga mpt msi msu nef odb ods ogg ogv p12 p7b pcd 
							 pdb pdf pem pfx pgp ph phar php pkg pl pm png potx ppsx ppt 
							 pptm pptx prop ps ps1 psd psp py pyc qt qt2 ra ram rar raw 
							 rb resx rm rsa rtf rub sass scss sh skin sln step stl svg 
							 swift sys tar tga tgz tif tiff torrent ts ttf txt udf vb 
							 vbproj vcd vcs vob vsd vss vst vsx vtx war wav wbk webinfo 
							 webm wma wmf wmv woff woff2 wsf xaml xcf xlm xls xlsm xlt 
							 xltm xltx xml xps xsd xsl xspf xz z zip zsh).freeze
      

		 ICONS_VIVID =    %w(3g2 3ga 3gp 7z aa aac accdb accdt adn ai aif aifc aiff ait 
							 amr ani apk app asax ascx asf ash ashx asmx asp aspx asx au 
							 aup avi axd aze bak bash bat bin blank bmp bpg browser bz2 c
							 cab caf cal cd cer class cmd com compile config cpp cr2 crt 
							 crypt cs csh csproj css csv cue dat db dbf deb dgn dist dll 
							 dmg dng doc docb docm docx dot dotm dotx dpj ds_store dtd 
							 dwg dxf eot eps epub exe f4v fax fb2 fla flac flv folder 
							 gadget gem gif gitignore go gpg gz h htm html ibooks ico ics 
							 idx iff image img indd inf ini iso jar java jpe jpeg jpg js 
							 json jsp key kf8 ksh less licx lit lock log lua m2v m3u m3u8 
							 m4a m4r m4v map master md mdb mdf mid midi mkv mobi mov mp2 
							 mp3 mp4 mpa mpd mpe mpeg mpg mpga mpp mpt msi msu nef nes 
							 odb ods odt ogg ogv ost otf ott ovf p12 p7b pages part pcd 
							 pdb pdf pem pfx pgp ph phar php pkg pl pm png po pot potx 
							 pps ppsx ppt pptm pptx prop ps psd psp pst pub py pyc qt ra 
							 ram rar raw rb rdf resx rm rpm rsa rtf rub sass scss sdf sh 
							 sitemap skin sldm sldx sln sql step stl svg swd swf swift 
							 sys tar tcsh tex tga tgz tif tiff torrent ts tsv ttf txt udf 
							 vb vbproj vcd vcs vdi vdx vmdk vob vsd vss vst vsx vtx war 
							 wav wbk webinfo webm webp wma wmf wmv woff woff2 wsf xaml 
							 xcf xlm xls xlsm xlsx xlt xltm xltx xml xpi xps xrb xsd xsl 
							 xspf xz yaml yml z zip zsh).freeze       
							 
		def thumbnail_with_icon
		
		  if @attachment.thumbnailable? && tbnail = @attachment.thumbnail(:size => params[:size])
			if stale?(:etag => tbnail)
			  send_file tbnail,
			    :filename => filename_for_content_disposition(File.basename(tbnail)),
			#	:filename => filename_for_content_disposition(@attachment.filename),
				:type => Redmine::MimeType.of(tbnail).to_s,
				:disposition => 'inline'
			end
			
		  else
		  
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
		   
		   if icon_set.include? extn = File.extname(@attachment.filename).downcase[1..-1]
			 icon_path = File.join(Rails.root, "public", "plugin_assets", "redmine_all_thumbnails", "images", "icons", icon_dir, "#{extn}.svg")
			 send_file icon_path,
				  :filename => filename_for_content_disposition("#{extn}.svg"),
				  :type => 'image/svg+xml',
				  :disposition => 'inline'
   
		   else
			   # No icon for the attachment was found
			  icon_path = File.join(Rails.root, "public", "plugin_assets", "redmine_all_thumbnails", "images", "icons", icon_dir, "blank.svg" )
			  send_file icon_path,
				  :filename => filename_for_content_disposition("#{extn}.svg"),
				  :type => 'image/svg+xml',
				  :disposition => 'inline'
			end #if
		  end #if
		end #def

      end #module      

      module ClassMethods
      end #def 

    end #module
  end #module
end #module

unless AttachmentsController.included_modules.include?(RedmineAllThumbnails::Patches::AttachmentsControllerPatch)
    AttachmentsController.send(:include, RedmineAllThumbnails::Patches::AttachmentsControllerPatch)
end


