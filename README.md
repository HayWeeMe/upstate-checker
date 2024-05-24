# upstate-checker
Pure bash script that pings a machine and returns if the ping was successful or not into a log file, can also run commands on state change (from UP to DOWN or vice versca)

This is just a simple script that I wrote for personal reasons, useful for quickly checking if a remote server went down or not.
I wanted something that was pure bash and didn't need any dependencies (as far as I know) and that can do some simple logging and state watching.
The way I personally use this script is by running a curl command to my ntfy serer on my RPI whenever the state of my ubuntu server goes up or down to get a notifaction on my phone.

`curl -u #USERNAME#:#PASSWORD# -d "Server went DOWN!!!" x.x.x.x:xxxx/health`

The possiblities are virtually endless as you can pretty much run any command by replacing the `# YOUR X STATE COMMAND GOES HERE` inside the script before running it.

# Configuring the script

Before running the script please take a moment to read through the comments and edit it with any text editor (nano, vim...etc) to customize it however you want. The script will not work if you do not at least set the IP address of the server/device you want to ping check. You can also change the location of the log and state files for example as they are saved by default in your home directory at `$HOME/scripts/logs/`. Furhter down in the script there are also comments that help guide you where you can write your own commands to run when the state of the server/device being checked changes.

# Running the script

The script can be ran like any normal bash script, for example `bash /path/to/script/upstate-checker.sh`. Preferably you'd want it to run in an automated fashion, for example I edited my crontab using `crontab -e` and then added this line at the end to run the script once every five minutes `*/5 * * * * /home/pi/scripts/upstate-checker.sh`
