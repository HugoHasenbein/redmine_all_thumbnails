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
#
# **1.0.4** enhanced visual appearance of config dialog 
# - cleaned up and simplified code
# - added configuration choice to unselect images and pdf for icons
# **1.0.3** enhanced compatibility with other preview plugins
# - added icon for eml-files (email) to icon set 2
# **1.0.2** Moved parts of code to enhance compatibility with other plugins
# - separated functionality from Redmine Thumbnail PDF
# - separated functionality from Redmine Preview PDF
# - added setup choice to either use SVG (fast) or PNG (more compatible) as thumbnails / icons
# 
# **1.0.1** Running on Redmine 3.4.6

require 'redmine'

Redmine::Plugin.register :redmine_all_thumbnails do
  name 'Redmine All Thumbnails'
  author 'Stephan Wenzel'
  description 'This is a plugin for Redmine to show all files as file icons or thumnails'
  version '1.0.4'
  url 'https://github.com/HugoHasenbein/redmine_all_thumbnails'
  author_url 'https://github.com/HugoHasenbein/redmine_all_thumbnails'

  settings :default => {'use_icon_set' 	=> 'Icons-Square-O',
                        'use_svg'       => '1',
                        'image_icons'   => '1',
                        'pdf_icons'     => '1'
                        },
           :partial => 'settings/redmine_all_thumbnails/plugin_settings'

end

REDMINE_ALL_THUMBNAILS_CONVERT_BIN = 
  ( Redmine::Configuration['imagemagick_convert_command'] || 
    'convert'
  ).freeze

require "redmine_all_thumbnails"

