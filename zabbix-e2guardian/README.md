# Zabbix 3.4 - E2Guardian 4.1.x Template

## Introduction
This is my approach for a performance monitoring Template of [E2guardian](http://e2guardian.org/).

This Template was created on and for Zabbix 3.4 and E2Guardian 4.1.x on Debian 9 Stretch.

## Installation

1. Zabbix Agent should be installed, configured and working.
1. [EnableRemoteCommands=1](https://www.zabbix.com/documentation/3.4/manual/appendix/config/zabbix_agentd) must be set in zabbix_agentd.conf.
   1. It is possible to convert the system.run items into [User parameters](https://www.zabbix.com/documentation/3.4/manual/config/items/userparameters), but I like to have as much configuration as possible in the template.
1. The [E2Guardian dstats.log](https://github.com/e2guardian/e2guardian/blob/master/notes/dstats_format) settings should be configured and enabled.
   1. dstatlocation = /path/to/dstats.log
   1. dstatinterval = 300  # = 5 minutes
1. Import the Template.
1. Link the Template to your E2guardian Host.
1. Check the User Macro, if the Path to the dstats.log fits your configuration.

## Example

![Latest Data](example01.png)
