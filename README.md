# Getting started
1. Make the setup script executable `chmod +x setup.sh`
2. Run the setup script with two arguments `./setup.sh <~/Documents> <gdriveDirectory>`
3. Follow the prompts to get gdrive tool setup. You will have to log into your google account and allow it.
4. Now the setup script should sync your local directory to google drive automatically.

**NOTE:** The setup script sets up a daemon using fswatch to monitor the local directory.  If any change occurs in
that directory it will be automatically uploaded to the specified gdrive directory.


