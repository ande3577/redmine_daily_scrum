# Redmine Daily Scrum

## Overview

This plugin a allows answering and reviewing the three daily scrum questions

It is compatible with versions 2.4.x and 2.5.x.  Other versions may or may not work.

Please report issues to: 
  https://github.com/ande3577/redmine_daily scrum/

## Installation

1.  Clone to the plugins/redmine_daily_scrum directory
1.  Migrate the database
1.  Restart server
1.  Setup permissions in the redmine roles/permissions settings

## Usage

Navigate to the daily scrum project tab.  The daily scrum information for the current 
day will be shown.

![daily scrum view](img/redmine_daily_scrum_scrum_show.png "Current day's daily scrum")

Click Next/Previous to go to the next/previous day's daily scrum.  Click on the date 
checker to pick the date to check via a calendar.

Clicking Edit will allow for answering the daily scrum questions for each member.
There is also a field to record post scrum activities that need to be performed.  All
text fields support wiki formatting.

![daily scrum edit](img/redmine_daily_scrum_edit.png "Edit daily scrum")

Clicking Manage Members will allow defining the members of the scrum team that will 
appear on the scrum.  The order the users appear in the scrum list can also be modified.

![daily scrum members](img/redmine_daily_scrum_manage_members.png "Manage scrum team members")


## License

This program is free software: you can redistribute it and/or modify 
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
