# upstate-checker
Pure bash script that pings a machine and returns if the ping was successful or not into a log file, can also run commands on state change (from UP to DOWN or vice versca)

This is just a simple script that I wrote for personal reasons, useful for quickly checking if a remote server went down or not.
I wanted something that was pure bash and didn't need any dependencies (as far as I know) and that can do some simple logging and state watching.
The way I personally use this script is by running a curl command to my ntfy serer on my RPI whenever the state of my ubuntu server goes up or down to get a notifaction on my phone.
```curl -u #USERNAME#:#PASSWORD# -d "Server went DOWN!!!" x.x.x.x:xxxx/health```

The possiblities are virtually endless as you can pretty much run any command by replacing the `# YOUR X STATE COMMAND GOES HERE` inside the script before running it.
