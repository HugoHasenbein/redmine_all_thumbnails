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

require 'redmine'

Redmine::Plugin.register :redmine_all_thumbnails do
  name 'Redmine All Thumbnails'
  author 'Stephan Wenzel'
  description 'This is a plugin for Redmine to show all files as file icons or thumnails'
  version '1.0.2'
  url 'https://github.com/HugoHasenbein/redmine_all_thumbnails'
  author_url 'https://github.com/HugoHasenbein/redmine_all_thumbnails'

  settings :default => {'use_icon_set' 	=> 'Icons-Square-O'
                        },
           :partial => 'settings/redmine_all_thumbnails/plugin_settings'

end

require "redmine_all_thumbnails"
