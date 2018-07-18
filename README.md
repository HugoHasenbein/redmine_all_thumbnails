# redmine_all_thumbnails

Plugin for Redmine. Show every issue attachment as either thumnailable image or as a file icon

![PNG that represents a quick overview](/doc/Overview.png)

### Use case(s)

* View issue attachments similar to files in a graphical file browser like Explorer, Finder, KDE, etc

### Install

1. go to plugins folder

`git clone https://github.com/HugoHasenbein/redmine_all_attachments.git`

2. restart server f.i.  

`sudo /etc/init.s/apache2 restart`

### Uninstall

1. go to plugins folder

`rm -r redmine_all_attachments`

2. restart server f.i. 

`sudo /etc/init.s/apache2 restart`

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
              Separeted functionality from Redmine Thumbnail PDF
              Separated functionality from Redmine Preview PDF
              Added setup choice to either use SVG (fast) or PNG (more compatible) as thumbnails / icons
**1.0.1** Running on Redmine 3.4.6
