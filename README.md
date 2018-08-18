# redmine_all_thumbnails

Plugin for Redmine. Show every issue attachment as either thumnailable image or as a file icon

![PNG that represents a quick overview](/doc/Overview.png)

### Use case(s)

* View issue attachments similar to files in a graphical file browser like Explorer, Finder, KDE, etc

### Install

1. download plugin and copy plugin folder redmine_all_thumbnails go to Redmine's plugins folder (no need to migrate)

2. restart server f.i.  

### Uninstall

1. go to plugins folder, delete plugin folder redmine_all_thumbnails

`rm -r redmine_all_thumbnails`

2. restart server f.i. 

`sudo /etc/init.d/apache2 restart`

### Use

* Go to Administration->plugins and choose 
- your favorite icon set. (Source: https://github.com/dmhendricks/file-icon-vectors)
- use SVG (faster) or PNG (more compatibl) file format as thumbnails / icons
* Go to Administration->Settings->Display and choose "Display attachment thumbnails"
* Go to issues and view your attachments as file icons or thumbnailable images

**Have fun!**

### Localisations

* English
* German

### Change-Log* 

**1.0.2** Moved parts of code to enhance compatibility with other plugins
- Separeted functionality from Redmine Thumbnail PDF
- Separated functionality from Redmine Preview PDF
- Added setup choice to either use SVG (fast) or PNG (more compatible) as thumbnails / icons

**1.0.1** Running on Redmine 3.4.6
