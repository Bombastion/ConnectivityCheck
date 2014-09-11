ConnectivityCheck
=================

Ever get annoyed when your Internet connection drops out?  
Can't decide how irate to be without some metrics?  
If so, this is the script for you!

This is a collection of simple tools making use of command line staples to verify network connectivity.


Linux
=================

These instructions assume you know how to open a terminal in Linux and move around a bit.  If you're familiar with scripting in Linux, you can probably just read the file.

Download the connectivityCheck.sh script.  Make sure it's marked as runnable ('chmod 755 connectivityCheck.sh').  Also, make sure you have bash installed somewhere ('which bash' tells you where).
It requires a bit of configuration based on personal taste and network setup.  Here's a quick rundown of the values specified at the top of the script.

#!/bin/bash
Not technically a value used by the script, but it determines what program runs the file.  Make sure this matches the actual location of bash on your system.

connectivityOutputFile
The location of the file to write the logging to.  It's assumed that the user running the script has write privilege to that file.

site
The name of the external site to try to hit.  I chose Google by default since they can handle a ping every 30 seconds.  I also recommend a logical name rather than an IP because this tests connection to your ISP's DNS.

internalHost
Less necessary to the functionality of the script, but this is a host on your network.  The purpose of this is to verify that your network's still up when the external network's down.  I recommend your router or a machine that's always up.

waitTimeActive
The amount of time to wait between pings to the external site.

waitTimeInactive
The amount of time to wait between pings after an outage has been detected.

pingTimeout
The amount of time to give the external site to respond to your ping.  The default of 2 seconds is more than reasonable in most places.


To run the script, pop open a terminal and navigate to the directory you downloaded it to.  I prefer to have it running in the background so it keeps going even after I close the terminal.
Once you're in the directory, run
./connectivityCheck.sh&

That's it!  The next time the external site doesn't response, it'll be logged.

There's also timeDiff.sh in the Linux folder, which is a quick way to find out how long each outage lasts.  The location of the output log is hardcoded, so you should change that to wherever you actually put that file.  
Additionally, it currently requires that you have write access to your current directory.  I'll replace those with calls to mktemp if I'm feeling ambitious.
